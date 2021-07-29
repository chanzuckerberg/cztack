package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestAWSIAMRole(t *testing.T) {
	test := tftest.Test{

		Setup: func(t *testing.T) *terraform.Options {
			roleName := tftest.UniqueID()

			principals := []interface{}{
				map[string]interface{}{
					"type":        "Service",
					"identifiers": []string{"firehose.amazonaws.com"},
				},
			}

			options := tftest.Options(
				tftest.IAMRegion,
				map[string]interface{}{
					"role_name":  roleName,
					"principals": principals,
				},
			)

			return options
		},

		Validate: func(t1 *testing.T, options *terraform.Options) {
			r := require.New(t)
			region := options.EnvVars["AWS_DEFAULT_REGION"]
			r.NotEmpty(region)
			outputs := terraform.OutputAll(t, options)
			r.NotEmpty(outputs)
			roleName := outputs["role_name"].(string)
			r.NotEmpty(roleName)
		},
		Cleanup: func(t1 *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
