package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
)

func TestAWSIAMGroupConsoleLogin(t *testing.T) {

	terraformOptions := testutil.Options(
		testutil.IAMRegion,

		map[string]interface{}{
			"group_name": random.UniqueId(),
			"iam_path":   fmt.Sprintf("/%s/", random.UniqueId()),
		},
	)

	defer testutil.Cleanup(t, terraformOptions)

	testutil.Run(t, terraformOptions)
}
