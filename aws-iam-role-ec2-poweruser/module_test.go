package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSIAMRoleEcsPoweruser(t *testing.T) {

	curAcct := testutil.AWSCurrentAccountId(t)

	terraformOptions := testutil.Options(
		testutil.IAMRegion,
		map[string]interface{}{
			"role_name":         random.UniqueId(),
			"source_account_id": curAcct,
			"tags": map[string]string{
				"test": random.UniqueId(),
			},
		},
	)

	defer terraform.Destroy(t, terraformOptions)

	testutil.Run(t, terraformOptions)
}
