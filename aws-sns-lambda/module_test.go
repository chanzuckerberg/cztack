package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSSNSLambdaInit(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}

func TestAWSSNSLambdaDefaults(t *testing.T) {
	t.Parallel()

	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			project := tftest.UniqueID()
			env := tftest.UniqueID()
			service := tftest.UniqueID()
			owner := tftest.UniqueID()

			lambda_handler  := tftest.RandomString(tftest.AlphaNum, 8)
			lambda_runtime  := "nodejs12.x"
			lambda_zip_file := tftest.RandomString(tftest.AlphaNum, 8)

			return tftest.Options(
				tftest.DefaultRegion,
				map[string]interface{}{
					"project":        project,
					"env":            env,
					"service":        service,
					"owner":          owner,
					"lambda_handler":  lambda_handler,
					"lambda_runtime":  lambda_runtime,
					"lambda_zip_file": lambda_zip_file,
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
