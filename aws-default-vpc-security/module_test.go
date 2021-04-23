package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSDefaultVPCSecurity(t *testing.T) {
	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			// Not using tftest.Options because module does not take standard arguments
			return &terraform.Options{
				TerraformDir: ".",

				EnvVars: map[string]string{
					"AWS_DEFAULT_REGION": tftest.DefaultRegion,
				},
			}
		},

		Mode: tftest.Plan,

		Validate: func(t *testing.T, options *terraform.Options) {},
	}
	test.Run(t)
}
