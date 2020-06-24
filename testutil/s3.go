package testutil

import "encoding/json"

type S3BucketPolicy struct {
	Statement []struct {
		Sid       string
		Effect    string
		Principal string
		Action    string
		Resource  string
		Condition map[string]map[string]string
	}
}

// UnmarshalS3BucketPolicy will parse an s3 bucket policy and return as a go struct. Only parts that
// have been used are supported so far
func UnmarshalS3BucketPolicy(in string) (*S3BucketPolicy, error) {
	p := &S3BucketPolicy{}
	err := json.Unmarshal([]byte(in), p)
	return p, err
}
