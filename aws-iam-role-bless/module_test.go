package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestIAMRoleBless(t *testing.T) {
	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			curAcct := tftest.AWSCurrentAccountID(t)

			return tftest.Options(
				tftest.IAMRegion,
				map[string]interface{}{
					"role_name":         random.UniqueId(),
					"source_account_id": curAcct,
					"bless_lambda_arns": []string{"arn:aws:lambda:us-west-2:111111111111:function:test"},
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
