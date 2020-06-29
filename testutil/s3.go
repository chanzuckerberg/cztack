package testutil

import (
	"encoding/json"
	"strconv"
	"testing"

	"github.com/aws/aws-sdk-go/service/iam"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/stretchr/testify/require"
)

type S3BucketPolicy struct {
	Statement []struct {
		Sid       string
		Effect    string
		Principal string
		Action    string
		Resource  []string
		Condition map[string]map[string]string
	}
}

var UserArn = "arn:aws:iam::119435350371:user/ci/cztack-ci"

// UnmarshalS3BucketPolicy will parse an s3 bucket policy and return as a go struct. Only parts that
// have been used are supported so far
func UnmarshalS3BucketPolicy(in string) (*S3BucketPolicy, error) {
	p := &S3BucketPolicy{}
	err := json.Unmarshal([]byte(in), p)
	return p, err
}

// S3S3SimulateRequest uses the IAM policy simulator to run end-to-end tests on permissions
func S3SimulateRequest(t *testing.T, region, action, bucketArn, bucketPolicy string, secureTransport bool) *iam.EvaluationResult {
	r := require.New(t)

	iamClient := aws.NewIamClient(t, region)

	simRequest := &iam.SimulatePrincipalPolicyInput{
		ActionNames: []*string{&action},
		CallerArn:   &UserArn,
		ContextEntries: []*iam.ContextEntry{
			{
				ContextKeyName:   Strptr("aws:securetransport"),
				ContextKeyType:   Strptr("boolean"),
				ContextKeyValues: []*string{Strptr(strconv.FormatBool(secureTransport))},
			},
		},
		ResourceArns:    []*string{&bucketArn},
		PolicySourceArn: &UserArn,
		ResourcePolicy:  &bucketPolicy,
	}

	resp, err := iamClient.SimulatePrincipalPolicy(simRequest)
	r.NoError(err)
	r.NotNil(resp.EvaluationResults)
	r.Len(resp.EvaluationResults, 1)

	return resp.EvaluationResults[0]
}
