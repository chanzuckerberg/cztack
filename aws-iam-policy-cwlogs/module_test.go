package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSIAMPolicyCwlogs(t *testing.T) {
	roleName := tftest.CreateRole(t)
	defer tftest.DeleteRole(t, roleName) //nolint

	terraformOptions := &terraform.Options{
		TerraformDir: ".",

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": tftest.IAMRegion,
		},
		Vars: map[string]interface{}{
			"role_name": roleName,
			"iam_path":  fmt.Sprintf("/%s/", random.UniqueId()),
		},
	}

	defer tftest.Cleanup(t, terraformOptions)

	tftest.Run(t, terraformOptions)
}
