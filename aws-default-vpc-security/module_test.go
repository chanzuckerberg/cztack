package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSDefaultVPCSecurity(t *testing.T) {
	test := testutil.Test{
		Setup: func(t *testing.T) *terraform.Options {
			return testutil.Options(
				testutil.DefaultRegion,
				map[string]interface{}{},
			)
		},

		Mode: testutil.Plan,

		Validate: func(t *testing.T, options *terraform.Options) {},
	}
	test.Run(t)
}
