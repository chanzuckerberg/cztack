package test

import (
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

			// get a client to query for other assertions
			s3Client := aws.NewS3Client(t, region)

			acl, err := s3Client.GetBucketAcl(&s3.GetBucketAclInput{
				Bucket: &bucket,
			})

			r.NoError(err)
			r.Len(acl.Grants, 2)

			r.Equal("CanonicalUser", *acl.Grants[0].Grantee.Type)
			r.Equal("FULL_CONTROL", *acl.Grants[0].Permission)
			r.Equal("c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0", *acl.Grants[1].Grantee.ID)
			r.Equal("FULL_CONTROL", *acl.Grants[1].Permission)
		},
	}
	test.Run(t)
}
