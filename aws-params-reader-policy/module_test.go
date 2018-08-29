package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSParamsSecretReaderPolicy(t *testing.T) {

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
			"AWS_DEFAULT_REGION": testutil.IAMRegion,
		},
	}

	defer testutil.Cleanup(t, setupTerraformOptions)

	testutil.Run(t, setupTerraformOptions)

	roleName := terraform.Output(t, setupTerraformOptions, "role_name")

	// SETUP Secrets policy

	keyAlias := random.UniqueId()
	keyTerraformOptions := &terraform.Options{
		TerraformDir: "../aws-params-secrets-setup",

		Vars: map[string]interface{}{
			"alias_name": keyAlias,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": testutil.IAMRegion,
		},
	}

	defer testutil.Cleanup(t, keyTerraformOptions)

	testutil.Run(t, keyTerraformOptions)

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
			"AWS_DEFAULT_REGION": testutil.IAMRegion,
		},
	}

	defer testutil.Cleanup(t, terraformOptions)

	testutil.Run(t, terraformOptions)

}
