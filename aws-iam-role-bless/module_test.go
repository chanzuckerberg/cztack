package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestIAMRoleBless(t *testing.T) {
	test := testutil.Test{
		Options: func(t *testing.T) *terraform.Options {
			region := testutil.IAMRegion
			curAcct := testutil.AWSCurrentAccountId(t)

			return &terraform.Options{
				TerraformDir: ".",

				Vars: map[string]interface{}{
					"role_name":         random.UniqueId(),
					"source_account_id": curAcct,
					"tags": map[string]string{
						"test": random.UniqueId(),
					},
					"bless_lambda_arns": []string{"arn:aws:lambda:us-west-2:111111111111:function:test"},
				},
				EnvVars: map[string]string{
					"AWS_DEFAULT_REGION": region,
				},
			}
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
