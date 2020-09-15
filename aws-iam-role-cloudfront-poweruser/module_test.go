package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSIAMRoleCloudfrontPoweruser(t *testing.T) {
	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			curAcct := tftest.AWSCurrentAccountID(t)

			return tftest.Options(
				tftest.IAMRegion,

				map[string]interface{}{
					"role_name":         random.UniqueId(),
					"iam_path":          fmt.Sprintf("/%s/", random.UniqueId()),
					"source_account_id": curAcct,
					"tags": map[string]string{
						"test": random.UniqueId(),
					},
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
