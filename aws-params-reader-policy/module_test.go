package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	log "github.com/sirupsen/logrus"
)

func init() {
	log.SetLevel(log.DebugLevel)
}

func TestAWSParamsSecretReaderPolicy(t *testing.T) {
	curAcct := testutil.AWSCurrentAccountId(t)

	log.Debug("SETUP ROLE")

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

	log.Debug("SETUP Secrets policy")

	keyAlias := random.UniqueId()
	keyTerraformOptions := &terraform.Options{
		TerraformDir: "../aws-params-secrets-setup",

		Vars: map[string]interface{}{
			"alias_name": keyAlias,
			"owner":      random.UniqueId(),
			"project":    random.UniqueId(),
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": testutil.IAMRegion,
		},
	}

	defer testutil.Cleanup(t, keyTerraformOptions)

	testutil.Run(t, keyTerraformOptions)

	// Actual test
	terraformOptions := testutil.Options(
		testutil.IAMRegion,
		map[string]interface{}{
			"project":                   random.UniqueId(),
			"env":                       random.UniqueId(),
			"service":                   random.UniqueId(),
			"role_name":                 roleName,
			"parameter_store_key_alias": keyAlias,
		},
	)

	defer testutil.Cleanup(t, terraformOptions)

	testutil.Run(t, terraformOptions)
}
