package test

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/aws/aws-sdk-go/service/cloudwatchlogs"
	"github.com/aws/aws-sdk-go/service/lambda"
	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestDefaults(t *testing.T) {
	test := tftest.Test{

		Setup: func(t *testing.T) *terraform.Options {
			project := tftest.UniqueID()
			env := tftest.UniqueID()
			service := tftest.UniqueID()
			owner := tftest.UniqueID()

			// vars are all encoded in the test terraform files
			opt := tftest.Options(
				tftest.DefaultRegion,
				map[string]interface{}{
					"project": project,
					"env":     env,
					"service": service,
					"owner":   owner,
				},
			)
			opt.TerraformDir = "./test"
			return opt
		},
		Validate: func(t *testing.T, options *terraform.Options) {
			r := require.New(t)
			l := aws.NewLambdaClient(t, tftest.DefaultRegion)

			arn := terraform.Output(t, options, "arn")
			invokeArn := terraform.Output(t, options, "invoke_arn")

			r.NotEmpty(invokeArn)
			_, e := l.GetFunction(&lambda.GetFunctionInput{
				FunctionName: tftest.Strptr(arn),
			})

			r.NoError(e)

			username := tftest.UniqueID()

			payload := struct {
				Name string `json:"name"`
			}{username}

			payloadBytes, e := json.Marshal(payload)
			r.NoError(e)

			ret, e := l.Invoke(&lambda.InvokeInput{
				FunctionName: tftest.Strptr(arn),
				LogType:      tftest.Strptr("Tail"),
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

			data := struct {
				Message       string `json:"message"`
				LogGroupName  string `json:"log_group_name"`
				LogStreamName string `json:"log_stream_name"`
				RequestID     string `json:"aws_request_id"`
			}{}
			e = json.Unmarshal(ret.Payload, &data)
			r.NoError(e)

			// check that we get the hello results back
			r.Equal(fmt.Sprintf(`Hello %s!`, username), data.Message)

			// test logs in response
			r.NotNil(ret.LogResult)
			logs, e := base64.StdEncoding.DecodeString(*ret.LogResult)
			r.NoError(e)
			r.Contains(string(logs), username)

			// give cloudwatch some time to catch up
			time.Sleep(10 * time.Second)

			// test logs via cloudwatch logs
			cw := aws.NewCloudWatchLogsClient(t, tftest.DefaultRegion)
			found := false
			err := cw.GetLogEventsPages(&cloudwatchlogs.GetLogEventsInput{
				LogGroupName:  &data.LogGroupName,
				LogStreamName: &data.LogStreamName,
				Limit:         tftest.Int64ptr(10000),
			}, func(evs *cloudwatchlogs.GetLogEventsOutput, _ bool) bool {
				for _, ev := range evs.Events {
					if strings.Contains(*ev.Message, username) {
						found = true
						return false
					}
					if strings.Contains(*ev.Message, fmt.Sprintf("END RequestId: %s", data.RequestID)) {
						return false
					}
				}
				return true
			})
			r.NoError(err)
			r.True(found)

			// log retention
			out, err := cw.DescribeLogGroups(&cloudwatchlogs.DescribeLogGroupsInput{
				LogGroupNamePrefix: &data.LogGroupName,
			})
			r.NoError(err)
			r.Len(out.LogGroups, 1)
			r.Equal(int64(1), *out.LogGroups[0].RetentionInDays)
		},
	}

	test.Run(t)
}
