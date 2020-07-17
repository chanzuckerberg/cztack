package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestBlessCAInit(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}

func TestBlessCAInitAndApply(t *testing.T) {
	// t.Skip("This test fails often due to AWS eventual-consistency issues. It's disabled until someone has a chance to fix it.")
	// t.Parallel()

	test := testutil.Test{
		Options: func(t *testing.T) *terraform.Options {
			project := testutil.UniqueId()
			env := testutil.UniqueId()
			service := "bless" // other components in the name are random so keep this to identify
			owner := testutil.UniqueId()

			region := testutil.IAMRegion

			return testutil.Options(
				region,
				map[string]interface{}{
					"project": project,
					"env":     env,
					"service": service,
					"owner":   owner,

					//test only
					"region":                     region,
					"bless_provider_aws_profile": testutil.EnvVar(testutil.EnvAWSProfile),
					"test_user_name":             fmt.Sprintf("bless-%s", testutil.UniqueId()),
				},
			)

		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
