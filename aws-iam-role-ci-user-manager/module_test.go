package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestAWSIAMRoleCIManager(t *testing.T) {
	currentAcct := tftest.AWSCurrentAccountID(t)
	testList := []tftest.Test{
		{
			Setup: func(t *testing.T) *terraform.Options {
				return tftest.Options(
					tftest.IAMRegion,
					map[string]interface{}{
						"caller_account_id": currentAcct,
						"sts_external_id":   random.UniqueId(),
					},
				)
			},
			Validate: validateFunc,
		},
	}
	for _, currentTest := range testList {
		currentTest.Run(t)
	}
}

func validateFunc(t *testing.T, options *terraform.Options) {
	r := require.New(t)
	region := options.EnvVars["AWS_DEFAULT_REGION"]
	r.NotEmpty(region)
	outputs := terraform.OutputAll(t, options)
	r.NotEmpty(outputs)
	roleName := outputs["role_name"].(string)
	r.NotEmpty(roleName)
	// TODO(anyone): figure out what it means to "test" this role
}
