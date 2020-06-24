package test

import (
	"testing"

	"github.com/aws/aws-sdk-go/service/s3"
	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/require"
)

func TestPrivateBucketDefaults(t *testing.T) {

	test := &TerraformTest{
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
			aws.AssertS3BucketExists(t, region, bucket)
			aws.AssertS3BucketPolicyExists(t, region, bucket)
			aws.AssertS3BucketVersioningExists(t, region, bucket)
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
		},
	}

	test.Run(t)
}

type TerraformTest struct {
	Options  func(*testing.T) *terraform.Options
	Validate func(*testing.T, *terraform.Options)
}

func (tt *TerraformTest) Run(t *testing.T) {
	terraformDirectory := "."

	defer test_structure.RunTestStage(t, "cleanup", func() {
		options := test_structure.LoadTerraformOptions(t, terraformDirectory)
		terraform.Destroy(t, options)
		testutil.Clean(terraformDirectory)
		test_structure.CleanupTestDataFolder(t, terraformDirectory)
	})

	test_structure.RunTestStage(t, "options", func() {
		options := tt.Options(t)
		test_structure.SaveTerraformOptions(t, terraformDirectory, options)
	})

	test_structure.RunTestStage(t, "apply", func() {
		options := test_structure.LoadTerraformOptions(t, terraformDirectory)
		testutil.Run(t, options)
	})

	test_structure.RunTestStage(t, "validate", func() {
		options := test_structure.LoadTerraformOptions(t, terraformDirectory)
		tt.Validate(t, options)
	})
}
