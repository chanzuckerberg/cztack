package test

import (
	"fmt"
	"testing"

	"github.com/aws/aws-sdk-go/service/iam"
	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAWSIAMPolicyCwlogs(t *testing.T) {
	t.Parallel()

	region := "us-west-1"
	curAcct := testutil.AWSCurrentAccountId(t)
	inputRoleName := random.UniqueId()
	setupTerraformOptions := &terraform.Options{
		TerraformDir: "../aws-iam-role-crossacct",

		Vars: map[string]interface{}{
			"role_name":         inputRoleName,
			"iam_path":          fmt.Sprintf("/%s/", random.UniqueId()),
			"source_account_id": curAcct,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": region,
		},
	}

	defer terraform.Destroy(t, setupTerraformOptions)

	terraform.InitAndApply(t, setupTerraformOptions)

	// This block added because the InitAndApply below would sometimes fail due.
	// to an apparently nonexistent role. Probably something to do with IAM
	// eventual consistency.
	iamClient := aws.NewIamClient(t, region)
	res, err := iamClient.GetRole(&iam.GetRoleInput{
		RoleName: &inputRoleName,
	})
	assert.Nil(t, err)
	assert.Equal(t, inputRoleName, *res.Role.RoleName)

	outputRoleName := terraform.Output(t, setupTerraformOptions, "role_name")

	terraformOptions := &terraform.Options{
		TerraformDir: ".",

		Vars: map[string]interface{}{
			"role_name": outputRoleName,
			"iam_path":  fmt.Sprintf("/%s/", random.UniqueId()),
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": region,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
