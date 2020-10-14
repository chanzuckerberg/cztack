package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAwsSnsLambda(t *testing.T) {
	region := tftest.IAMRegion

	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			opt := tftest.Options(
				region,
				map[string]interface{}{},
			)
			opt.TerraformDir = "./test"
			return opt
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
