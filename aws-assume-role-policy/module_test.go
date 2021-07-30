package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestAWSAssumeRolePolicy(t *testing.T) {
	curAcct := tftest.AWSCurrentAccountID(t)
	oidcCfg := []map[string]interface{}{
		{
			"idp_arn":    "oidcARN1",
			"client_ids": []string{"clientID1", "clientID2", "clientID3"},
			"provider":   "testProvider",
		},
	}

	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			options := tftest.Options(
				tftest.IAMRegion,
				map[string]interface{}{
					"source_account_ids": []string{curAcct},
					"saml_idp_arns":      []string{"samlARN1", "samlARN2"},
					"oidc":               oidcCfg,
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
			policy := outputs["json"].(string)
			r.NotEmpty(policy)
		},
		Cleanup: func(t1 *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
