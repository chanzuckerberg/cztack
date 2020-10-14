package test

import (
	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
)

func TestAWSSNSLambdaInit(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}

func TestBlessCAInitAndApply(t *testing.T) {
	region := tftest.IAMRegion

	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			return tftest.Options(
				region,
				map[string]interface{}{},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
