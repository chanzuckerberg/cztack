package testutil

import (
	"bytes"
	"fmt"
	"math"
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

const (
	// IAMRegion IAM is allegedly hosted in us-east-1, so use this region for IAM related things
	IAMRegion     = "us-east-1"
	DefaultRegion = "us-west-2"
)

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
	iamClient.DeleteRole(&iam.DeleteRoleInput{RoleName: &name}) //nolint
}

// Destroy with retries
func Destroy(t *testing.T, options *terraform.Options, retries ...int) {
	retryTimes := 3
	if len(retries) == 1 {
		retryTimes = retries[0]
	}
	var err error
	var output string
	for i := 0; i < retryTimes; i++ {
		output, err = terraform.DestroyE(t, options)
		if err == nil {
			return // Done
		}
		fmt.Printf("Retrying delete %d time...\n", i)
		fmt.Println(output)
		sleep := math.Min(math.Pow(2, float64(i)), 5*60) // Sleep maximum of 5 minutes
		time.Sleep(time.Duration(sleep) * time.Second)
	}
	// err should not be nil by this point
	t.Fatal(err)
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
	splitFn := func(c rune) bool {
		return c == ','
	}
	return strings.FieldsFunc(s, splitFn)
}

func EnvVar(name string) string {
	return os.Getenv(name)
}

func Options(region string, vars map[string]interface{}) *terraform.Options {
	return &terraform.Options{
		TerraformDir: ".",

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": region,
		},

		Vars: vars,
	}
}

// Lifted from https://github.com/gruntwork-io/terratest/blob/master/modules/random/random.go and modified
// to do lowercase only.
// TODO fork terratest and write a method for random strings that takes a list of acceptable characters.
const base62chars = "abcdefghijklmnopqrstuvwxyz"
const AlphaNum = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
const Alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
const uniqueIDLength = 6 // Should be good for 62^6 = 56+ billion combinations

// UniqueId returns a unique (ish) id we can attach to resources and tfstate files so they don't conflict with each other
// Uses base 62 to generate a 6 character string that's unlikely to collide with the handful of tests we run in
// parallel. Based on code here: http://stackoverflow.com/a/9543797/483528
func UniqueId() string {
	return RandomString(base62chars, uniqueIDLength)
}

// newRand creates a new random number generator, seeding it with the current system time.
func newRand() *rand.Rand {
	return rand.New(rand.NewSource(time.Now().UnixNano()))
}

func RandomString(chars string, length int) string {
	var out bytes.Buffer

	generator := newRand()
	for i := 0; i < length; i++ {
		out.WriteByte(chars[generator.Intn(len(chars))])
	}

	return out.String()
}

func Strptr(in string) *string {
	return &in
}
