package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSIAMGroupConsoleLogin(t *testing.T) {
	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			// Not using tftest.Options because module does not take standard arguments
			return &terraform.Options{
				TerraformDir: ".",

				EnvVars: map[string]string{
					"AWS_DEFAULT_REGION": tftest.IAMRegion,
				},

				Vars: map[string]interface{}{
					"group_name": random.UniqueId(),
					"iam_path":   fmt.Sprintf("/%s/", random.UniqueId()),
				},
			}
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
