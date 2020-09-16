package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSDefaultVPCSecurity(t *testing.T) {
	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			return tftest.Options(
				tftest.DefaultRegion,
				map[string]interface{}{},
			)
		},

		Mode: tftest.Plan,

		Validate: func(t *testing.T, options *terraform.Options) {},
	}
	test.Run(t)
}
