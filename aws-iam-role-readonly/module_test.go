package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
)

func TestAWSIAMRoleReadOnly(t *testing.T) {

	curAcct := testutil.AWSCurrentAccountId(t)

	terraformOptions := testutil.Options(
		testutil.IAMRegion,

		map[string]interface{}{
			"role_name":         random.UniqueId(),
			"source_account_id": curAcct,
			"iam_path":          fmt.Sprintf("/%s/", random.UniqueId()),
			"tags": map[string]string{
				"test": random.UniqueId(),
			},
		},
	)

	defer testutil.Cleanup(t, terraformOptions)

	testutil.Run(t, terraformOptions)
}
