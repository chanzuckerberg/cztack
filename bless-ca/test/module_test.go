package test

import (
	"fmt"
	"testing"

	"github.com/aws/aws-sdk-go/service/lambda"
	"github.com/chanzuckerberg/cztack/testutil"
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
	region := testutil.IAMRegion

	test := testutil.Test{
		Setup: func(t *testing.T) *terraform.Options {
			project := testutil.UniqueId()
			env := testutil.UniqueId()
			service := "bless" // other components in the name are random so keep this to identify
			owner := testutil.UniqueId()

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
		Validate: func(t *testing.T, options *terraform.Options) {
			r := require.New(t)
			outputs := terraform.OutputAll(t, options)
			l := aws.NewLambdaClient(t, region)

			_, e := l.GetFunction(&lambda.GetFunctionInput{
				FunctionName: testutil.Strptr(outputs["lambda_arn"].(string)),
			})
			r.NoError(e)
		},
	}

	test.Run(t)
}
