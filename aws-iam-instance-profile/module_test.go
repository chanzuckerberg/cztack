package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSIAMInstanceProfile(t *testing.T) {
	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			// Not using tftest.Options because module does not take standard arguments
			return &terraform.Options{
				TerraformDir: ".",

				EnvVars: map[string]string{
					"AWS_DEFAULT_REGION": tftest.IAMRegion,
				},

				Vars: map[string]interface{}{
					"name_prefix":      random.UniqueId(),
					"iam_path":         "/foo/",
					"role_description": random.UniqueId(),
				},
			}
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
