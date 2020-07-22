package test

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"testing"

	"os/user"

	"github.com/aws/aws-sdk-go/service/lambda"
	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestDefaults(t *testing.T) {

	test := testutil.Test{
		Options: func(t *testing.T) *terraform.Options {

			// vars are all encoded in the test terraform files
			opt := testutil.Options(
				testutil.DefaultRegion,
				map[string]interface{}{},
			)
			opt.TerraformDir = "./test"
			return opt
		},
		Validate: func(t *testing.T, options *terraform.Options) {
			r := require.New(t)
			l := aws.NewLambdaClient(t, testutil.DefaultRegion)

			arn := terraform.Output(t, options, "arn")
			invokeArn := terraform.Output(t, options, "invoke_arn")

			r.NotEmpty(invokeArn)
			_, e := l.GetFunction(&lambda.GetFunctionInput{
				FunctionName: testutil.Strptr(arn),
			})

			r.NoError(e)

			var username string
			u, err := user.Current()
			if err == nil {
				username = u.Name
			} else {
				username = "anonymous"
			}

			payload := struct {
				Name string `json:"name"`
			}{username}

			payloadBytes, e := json.Marshal(payload)
			r.NoError(e)

			ret, e := l.Invoke(&lambda.InvokeInput{
				FunctionName: testutil.Strptr(arn),
				LogType:      testutil.Strptr("Tail"),
				Payload:      payloadBytes,
			})
			r.NoError(e)

			r.Equal(int64(200), *ret.StatusCode)
			if ret.FunctionError != nil {
				t.Logf("function error %s", *ret.FunctionError)
				log, _ := base64.StdEncoding.DecodeString(*ret.LogResult)
				t.Log(string(log))
				t.Fail()
			}

			// check that we get the hello results back
			r.Equal(fmt.Sprintf(`"Hello %s!"`, username), string(ret.Payload))
		},
	}

	test.Run(t)
}
