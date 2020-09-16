package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/random"
)

func TestAWSIAMPolicyCwlogs(t *testing.T) {
	roleName := tftest.CreateRole(t)
	defer tftest.DeleteRole(t, roleName) //nolint

	terraformOptions := tftest.Options(
		tftest.IAMRegion,
		map[string]interface{}{
			"role_name": roleName,
			"iam_path":  fmt.Sprintf("/%s/", random.UniqueId()),
		},
	)

	defer tftest.Cleanup(t, terraformOptions)

	tftest.Run(t, terraformOptions)
}
