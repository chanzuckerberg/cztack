package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
)

func TestAWSIAMPolicyCwlogs(t *testing.T) {

	roleName := testutil.CreateRole(t)
	defer testutil.DeleteRole(t, roleName)

	terraformOptions := testutil.Options(
		testutil.IAMRegion,
		map[string]interface{}{
			"role_name": roleName,
			"iam_path":  fmt.Sprintf("/%s/", random.UniqueId()),
		},
	)

	defer testutil.Cleanup(t, terraformOptions)

	testutil.Run(t, terraformOptions)
}
