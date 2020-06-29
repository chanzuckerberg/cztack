package test

import (
	"fmt"
	"testing"

	"github.com/aws/aws-sdk-go/service/s3"
	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestPrivateBucketDefaults(t *testing.T) {

	test := &testutil.Test{
		Options: func(t *testing.T) *terraform.Options {
			project := testutil.UniqueId()
			env := testutil.UniqueId()
			service := testutil.UniqueId()
			owner := testutil.UniqueId()

			bucketName := testutil.UniqueId()

			return testutil.Options(
				testutil.DefaultRegion,
				map[string]interface{}{
					"project": project,
					"env":     env,
					"service": service,
					"owner":   owner,

					"bucket_name": bucketName,
				},
			)
		},

		Validate: func(t *testing.T, options *terraform.Options) {
			r := require.New(t)
			region := options.EnvVars["AWS_DEFAULT_REGION"]
			bucket := options.Vars["bucket_name"].(string)
			outputs := terraform.OutputAll(t, options)
			bucketArn := outputs["arn"].(string)

			// some assertions built into terratest
			aws.AssertS3BucketExists(t, region, bucket)
			aws.AssertS3BucketPolicyExists(t, region, bucket)
			aws.AssertS3BucketVersioningExists(t, region, bucket)

			bucketPolicy := aws.GetS3BucketPolicy(t, region, bucket)
			policy, err := testutil.UnmarshalS3BucketPolicy(bucketPolicy)
			r.NoError(err)
			r.NotNil(policy)

			r.Len(policy.Statement, 1)
			r.Equal(policy.Statement[0].Effect, "Deny")
			r.Equal(policy.Statement[0].Principal, "*")
			r.Equal(policy.Statement[0].Action, "*")
			r.Len(policy.Statement[0].Condition, 1)
			r.Equal(policy.Statement[0].Condition["Bool"]["aws:SecureTransport"], "false")

			// get a client to query for other assertions
			s3Client := aws.NewS3Client(t, region)

			acl, err := s3Client.GetBucketAcl(&s3.GetBucketAclInput{
				Bucket: &bucket,
			})

			r.NoError(err)
			r.Len(acl.Grants, 1)

			r.Equal("CanonicalUser", *acl.Grants[0].Grantee.Type)
			r.Equal("FULL_CONTROL", *acl.Grants[0].Permission)

			enc, err := s3Client.GetBucketEncryption(&s3.GetBucketEncryptionInput{
				Bucket: &bucket,
			})
			r.NoError(err)

			r.NotNil(enc.ServerSideEncryptionConfiguration)
			r.Len(enc.ServerSideEncryptionConfiguration.Rules, 1)

			block, err := s3Client.GetPublicAccessBlock(&s3.GetPublicAccessBlockInput{
				Bucket: &bucket,
			})
			r.NoError(err)
			r.NotNil(block)
			r.True(*block.PublicAccessBlockConfiguration.BlockPublicAcls)
			r.True(*block.PublicAccessBlockConfiguration.BlockPublicPolicy)
			r.True(*block.PublicAccessBlockConfiguration.IgnorePublicAcls)
			r.True(*block.PublicAccessBlockConfiguration.RestrictPublicBuckets)

			// policy simulations

			objectArn := fmt.Sprintf("%s/foo", bucketArn)

			sims := []struct {
				action          string
				secureTransport bool
				arn             string
				result          string
			}{
				// deny when not using https
				{"s3:ListBucket", false, bucketArn, "explicitDeny"},
				// allow with https
				{"s3:ListBucket", true, bucketArn, "allowed"},
				// deny when not using https
				{"s3:GetObject", false, objectArn, "explicitDeny"},
				// allow with https
				{"s3:GetObject", true, objectArn, "allowed"},
			}

			for _, test := range sims {
				resp := testutil.S3SimulateRequest(t, region, test.action, test.arn, bucketPolicy, test.secureTransport)
				r.Equal(test.result, *resp.EvalDecision)
			}
		},
	}

	test.Run(t)
}
