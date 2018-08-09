package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSIAMRoleInfraCI(t *testing.T) {
	// t.Parallel()

	curAcct := testutil.AWSCurrentAccountId(t)

	terraformOptions := &terraform.Options{
		TerraformDir: ".",

		Vars: map[string]interface{}{
			"role_name":         random.UniqueId(),
			"source_account_id": curAcct,
			"iam_path":          fmt.Sprintf("/%s/", random.UniqueId()),
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": testutil.IAMRegion,
		},
	}

	defer testutil.Cleanup(t, terraformOptions)

	testutil.Run(t, terraformOptions)
}
