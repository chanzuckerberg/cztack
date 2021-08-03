package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestAWSIAMRoleAdmin(t *testing.T) {
	curAcct := tftest.AWSCurrentAccountID(t)
	oidcCfg := []map[string]interface{}{
		{
			"idp_arn":    "oidcARN1",
			"client_ids": []string{"clientID1", "clientID2", "clientID3"},
			"provider":   "testProvider",
		},
	}
	singleSourceAcct := map[string]interface{}{
		"role_name":          random.UniqueId(),
		"source_account_ids": []string{curAcct},
		"iam_path":           fmt.Sprintf("/%s/", random.UniqueId()),
		"saml_idp_arns":      []string{"samlARN1", "samlARN2"},
		"oidc":               oidcCfg,
	}
	// TODO(anyone): see if we need a legit account ID or if we can put in "12345" for a second source account
	testList := []tftest.Test{
		{
			Setup: func(t *testing.T) *terraform.Options {
				return tftest.Options(
					tftest.IAMRegion,
					singleSourceAcct,
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
