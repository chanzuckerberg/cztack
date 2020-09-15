package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSIAMInstanceProfile(t *testing.T) {
	test := testutil.Test{
		Setup: func(t *testing.T) *terraform.Options {
			return testutil.Options(
				testutil.IAMRegion,
				map[string]interface{}{
					"name_prefix":      random.UniqueId(),
					"iam_path":         "/foo/",
					"role_description": random.UniqueId(),
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
