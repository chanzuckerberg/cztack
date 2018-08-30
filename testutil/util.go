package testutil

import (
	"bytes"
	"fmt"
	"math/rand"
	"os"
	"path/filepath"
	"strings"
	"testing"
	"time"

	"github.com/aws/aws-sdk-go/service/ec2"
	"github.com/aws/aws-sdk-go/service/iam"
	"github.com/aws/aws-sdk-go/service/sts"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

var IAMRegion = "us-east-1"
var DefaultRegion = "us-west-2"

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

func CreateSecurityGroup(t *testing.T, region, vpc string) string {
	name := UniqueId()
	ec2Client := aws.NewEc2Client(t, region)
	desc := "cztack test"

	input := &ec2.CreateSecurityGroupInput{
		GroupName:   &name,
		VpcId:       &vpc,
		Description: &desc,
	}

	output, e := ec2Client.CreateSecurityGroup(input)
	assert.NoError(t, e)

	return *output.GroupId
}

func DeleteSecurityGroup(t *testing.T, region, id string) {
	ec2Client := aws.NewEc2Client(t, region)
	input := &ec2.DeleteSecurityGroupInput{
		GroupId: &id,
	}
	_, e := ec2Client.DeleteSecurityGroup(input)
	assert.Nil(t, e)
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

func ListEnvVar(name string) []string {
	s := os.Getenv(name)
	return strings.Split(s, ",")
}

func EnvVar(name string) string {
	return os.Getenv(name)
}

// Lifted from https://github.com/gruntwork-io/terratest/blob/master/modules/random/random.go and modified
// to do lowercase only.
// TODO fork terratest and write a method for random strings that takes a list of acceptable characters.
const base62chars = "abcdefghijklmnopqrstuvwxyz"
const uniqueIDLength = 6 // Should be good for 62^6 = 56+ billion combinations

// UniqueId returns a unique (ish) id we can attach to resources and tfstate files so they don't conflict with each other
// Uses base 62 to generate a 6 character string that's unlikely to collide with the handful of tests we run in
// parallel. Based on code here: http://stackoverflow.com/a/9543797/483528
func UniqueId() string {
	var out bytes.Buffer

	generator := newRand()
	for i := 0; i < uniqueIDLength; i++ {
		out.WriteByte(base62chars[generator.Intn(len(base62chars))])
	}

	return out.String()
}

// newRand creates a new random number generator, seeding it with the current system time.
func newRand() *rand.Rand {
	return rand.New(rand.NewSource(time.Now().UnixNano()))
}
