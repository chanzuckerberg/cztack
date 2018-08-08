package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAWSParamsSecretReaderPolicy(t *testing.T) {
	t.Parallel()

	region := "us-west-1"
	curAcct := testutil.AWSCurrentAccountId(t)

	// SETUP ROLE

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

	_, err := terraform.InitAndApplyE(t, setupTerraformOptions)
	assert.Nil(t, err)
	roleName := terraform.Output(t, setupTerraformOptions, "role_name")

	// SETUP Secrets policy

	keyAlias := random.UniqueId()
	keyTerraformOptions := &terraform.Options{
		TerraformDir: "../aws-params-secrets-setup",

		Vars: map[string]interface{}{
			"alias_name": keyAlias,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": region,
		},
	}

	defer terraform.Destroy(t, keyTerraformOptions)

	_, err = terraform.InitAndApplyE(t, keyTerraformOptions)
	assert.Nil(t, err)

	// Actual test
	terraformOptions := &terraform.Options{
		TerraformDir: ".",

		Vars: map[string]interface{}{
			"project":                   random.UniqueId(),
			"env":                       random.UniqueId(),
			"service":                   random.UniqueId(),
			"role_name":                 roleName,
			"parameter_store_key_alias": keyAlias,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": region,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	_, err = terraform.InitAndApplyE(t, terraformOptions)

	assert.Nil(t, err)
}
