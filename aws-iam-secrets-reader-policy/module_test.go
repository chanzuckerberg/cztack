package test

import (
	"testing"
	"time"

	"github.com/aws/aws-sdk-go/service/secretsmanager"
	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestDefaults(t *testing.T) {
	test := tftest.Test{
		SkipDestroy: true,
		Setup: func(t *testing.T) *terraform.Options {
			// vars are all encoded in the test terraform files
			return &terraform.Options{
				TerraformDir: "./test",

				EnvVars: map[string]string{
					"AWS_DEFAULT_REGION": tftest.DefaultRegion,
				},
			}
		},

		Validate: func(t *testing.T, options *terraform.Options) {
			r := require.New(t)
			secret := terraform.Output(t, options, "secret")
			notSecret := terraform.Output(t, options, "not_secret")
			// Need sleep to allow IAM time to catch up and recognize that
			// test user is allowed to assume our roles.
			time.Sleep(10 * time.Second)

			{
				roleArn := terraform.Output(t, options, "role")
				sess, e := aws.NewAuthenticatedSession(tftest.DefaultRegion)
				r.NoError(e)
				sess2 := aws.AssumeRole(sess, roleArn)
				r.NotNil(sess2)

				sm := secretsmanager.New(sess2)

				_, e = sm.GetSecretValue(&secretsmanager.GetSecretValueInput{
					SecretId: tftest.Strptr(secret),
				})
				r.NoError(e)

				_, e = sm.GetSecretValue(&secretsmanager.GetSecretValueInput{
					SecretId: tftest.Strptr(notSecret),
				})
				r.Error(e)
			}

			{
				roleArn := terraform.Output(t, options, "not_role")
				sess, e := aws.NewAuthenticatedSession(tftest.DefaultRegion)
				r.NoError(e)
				sess2 := aws.AssumeRole(sess, roleArn)
				r.NotNil(sess2)

				sm := secretsmanager.New(sess2)
				_, e = sm.GetSecretValue(&secretsmanager.GetSecretValueInput{
					SecretId: tftest.Strptr(secret),
				})

				r.Error(e)
			}
		},
	}
	test.Run(t)
}
