package test

import (
	"fmt"
	"testing"

	"github.com/aws/aws-sdk-go/service/lambda"
	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestBlessCAInit(t *testing.T) {
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
				map[string]interface{}{
					//test only
					"region":                     region,
					"bless_provider_aws_profile": tftest.EnvVar(tftest.EnvAWSProfile),
					"test_user_name":             fmt.Sprintf("bless-%s", tftest.UniqueID()),
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {
			r := require.New(t)
			outputs := terraform.OutputAll(t, options)
			l := aws.NewLambdaClient(t, region)

			_, e := l.GetFunction(&lambda.GetFunctionInput{
				FunctionName: tftest.Strptr(outputs["lambda_arn"].(string)),
			})
			r.NoError(e)
		},
	}

	test.Run(t)
}
