package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	log "github.com/sirupsen/logrus"
)

func init() {
	log.SetLevel(log.DebugLevel)
}

func TestAWSParamsSecretReaderPolicy(t *testing.T) {
	curAcct := tftest.AWSCurrentAccountID(t)

	log.Debug("SETUP ROLE")

	setupTerraformOptions := &terraform.Options{
		TerraformDir: "../aws-iam-role-crossacct",

		Vars: map[string]interface{}{
			"role_name":         random.UniqueID(),
			"iam_path":          fmt.Sprintf("/%s/", random.UniqueID()),
			"source_account_id": curAcct,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": tftest.IAMRegion,
		},
	}

	defer tftest.Cleanup(t, setupTerraformOptions)

	tftest.Run(t, setupTerraformOptions)

	roleName := terraform.Output(t, setupTerraformOptions, "role_name")

	log.Debug("SETUP Secrets policy")

	keyAlias := random.UniqueID()
	keyTerraformOptions := &terraform.Options{
		TerraformDir: "../aws-params-secrets-setup",

		Vars: map[string]interface{}{
			"alias_name": keyAlias,
			"owner":      random.UniqueID(),
			"project":    random.UniqueID(),
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": tftest.IAMRegion,
		},
	}

	defer tftest.Cleanup(t, keyTerraformOptions)

	tftest.Run(t, keyTerraformOptions)

	// Actual test
	terraformOptions := tftest.Options(
		tftest.IAMRegion,
		map[string]interface{}{
			"project":                   random.UniqueID(),
			"env":                       random.UniqueID(),
			"service":                   random.UniqueID(),
			"role_name":                 roleName,
			"parameter_store_key_alias": keyAlias,
		},
	)

	defer tftest.Cleanup(t, terraformOptions)

	tftest.Run(t, terraformOptions)
}
