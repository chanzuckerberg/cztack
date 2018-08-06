package role_test

import (
	"fmt"
	"testing"

	"github.com/aws/aws-sdk-go/service/sts"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestAWSIAMPolicyCwlogs(t *testing.T) {
	t.Parallel()

	region := "us-west-1"
	session, err := aws.NewAuthenticatedSession(region)
	assert.Nil(t, err)
	stsClient := sts.New(session)

	caller, err := stsClient.GetCallerIdentity(&sts.GetCallerIdentityInput{})
	assert.Nil(t, err)
	curAcct := *caller.Account
	assert.NotNil(t, curAcct)

	setupTerraformOptions := &terraform.Options{
		TerraformDir: "../aws-iam-role-crossacct",

		Vars: map[string]interface{}{
			"role_name":         random.UniqueId(),
			"iam_path":          fmt.Sprintf("/%s/", random.UniqueId()),
			"source_account_id": curAcct,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": region,
		},
	}

	defer terraform.Destroy(t, setupTerraformOptions)

	_, err = terraform.InitAndApplyE(t, setupTerraformOptions)
	assert.Nil(t, err)

	roleName := terraform.Output(t, setupTerraformOptions, "role_name")
	terraformOptions := &terraform.Options{
		TerraformDir: ".",

		Vars: map[string]interface{}{
			"role_name": roleName,
			"iam_path":  fmt.Sprintf("/%s/", random.UniqueId()),
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": region,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	_, err = terraform.InitAndApplyE(t, terraformOptions)

	assert.Nil(t, err)

	// Run `terraform output` to get the value of an output variable
	// terraform.Output(t, terraformOptions, "example")

	// Verify we're getting back the variable we expect
	// assert.Equal(t, expectedText, actualText)
}
