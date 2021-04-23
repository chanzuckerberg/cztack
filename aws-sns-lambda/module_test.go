package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAwsSnsLambda(t *testing.T) {
	test := tftest.Test{
		// Not using tftest.Options because module does not take standard arguments
		Setup: func(t *testing.T) *terraform.Options {
			return &terraform.Options{
				TerraformDir: "./test",

				EnvVars: map[string]string{
					"AWS_DEFAULT_REGION": tftest.IAMRegion,
				},
			}
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
