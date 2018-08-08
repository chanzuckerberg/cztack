package testutil

import (
	"fmt"
	"os"
	"path/filepath"
	"testing"

	"github.com/aws/aws-sdk-go/service/iam"
	"github.com/aws/aws-sdk-go/service/sts"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

var IAMRegion = "us-east-1"

func AWSCurrentAccountId(t *testing.T) string {
	session, err := aws.NewAuthenticatedSession(IAMRegion)
	assert.Nil(t, err)
	stsClient := sts.New(session)

	caller, err := stsClient.GetCallerIdentity(&sts.GetCallerIdentityInput{})
	assert.Nil(t, err)
	curAcct := *caller.Account
	assert.NotNil(t, curAcct)
	return curAcct
}

// CreateRole will create a new role with a random name and path and return the name.
func CreateRole(t *testing.T) string {
	a := assert.New(t)
	currAcct := AWSCurrentAccountId(t)
	roleName := random.UniqueId()
	assumeRoleDocument := `{
		"Version": "2012-10-17",
		"Statement": {
			"Effect": "Allow",
			"Principal": {
			"AWS": "arn:aws:iam::%s:root"
			},
			"Action": "sts:AssumeRole"
		}
		}`

	iamClient := aws.NewIamClient(t, IAMRegion)

	policy := fmt.Sprintf(assumeRoleDocument, currAcct)
	_, err := iamClient.CreateRole(&iam.CreateRoleInput{
		RoleName:                 &roleName,
		AssumeRolePolicyDocument: &policy,
	})
	a.Nil(err)

	_, err = iamClient.GetRole(&iam.GetRoleInput{RoleName: &roleName})
	a.Nil(err)
	return roleName
}

func DeleteRole(t *testing.T, name string) {
	iamClient := aws.NewIamClient(t, IAMRegion)
	iamClient.DeleteRole(&iam.DeleteRoleInput{RoleName: &name})
}

func Run(t *testing.T, options *terraform.Options) {
	Clean(options.TerraformDir)
	terraform.InitAndApply(t, options)
}

func Clean(dir string) {
	os.Remove(filepath.Join(dir, "terraform.tfstate"))
	os.Remove(filepath.Join(dir, "terraform.tfstate.backup"))
}

func Cleanup(t *testing.T, options *terraform.Options) {
	terraform.Destroy(t, options)
	Clean(options.TerraformDir)
}
