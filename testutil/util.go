package testutil

import (
	"testing"

	"github.com/aws/aws-sdk-go/service/sts"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/stretchr/testify/assert"
)

func AWSCurrentAccountId(t *testing.T) string {
	region := "us-west-1" // We can run this one on any region
	session, err := aws.NewAuthenticatedSession(region)
	assert.Nil(t, err)
	stsClient := sts.New(session)

	caller, err := stsClient.GetCallerIdentity(&sts.GetCallerIdentityInput{})
	assert.Nil(t, err)
	curAcct := *caller.Account
	assert.NotNil(t, curAcct)
	return curAcct
}
