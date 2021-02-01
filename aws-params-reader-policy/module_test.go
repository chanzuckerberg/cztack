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

	setupTerraformOptions := tftest.Options(
		tftest.IAMRegion,
		map[string]interface{}{
			"role_name":         random.UniqueId(),
			"iam_path":          fmt.Sprintf("/%s/", random.UniqueId()),
			"source_account_id": curAcct,
		},
	)
	setupTerraformOptions.TerraformDir = "../aws-iam-role-crossacct"

	defer tftest.Cleanup(t, setupTerraformOptions)

	tftest.Run(t, setupTerraformOptions)

	roleName := terraform.Output(t, setupTerraformOptions, "role_name")

	log.Debug("SETUP Secrets policy")

	keyAlias := random.UniqueId()
	keyTerraformOptions := tftest.Options(
		tftest.IAMRegion,
		map[string]interface{}{
			"alias_name": keyAlias,
			"owner":      random.UniqueId(),
			"project":    random.UniqueId(),
		},
	)
	keyTerraformOptions.TerraformDir = "../aws-params-secrets-setup"

	defer tftest.Cleanup(t, keyTerraformOptions)

	tftest.Run(t, keyTerraformOptions)

	// Actual test
	terraformOptions := tftest.Options(
		tftest.IAMRegion,
		map[string]interface{}{
			"project":                   random.UniqueId(),
			"env":                       random.UniqueId(),
			"service":                   random.UniqueId(),
			"role_name":                 roleName,
			"parameter_store_key_alias": keyAlias,
		},
	)

	defer tftest.Cleanup(t, terraformOptions)

	tftest.Run(t, terraformOptions)
}
