package test

import (
	"strconv"
	"testing"

	"github.com/stretchr/testify/assert"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestBlessCAInit(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}

func TestBlessCAInitAndApply(t *testing.T) {
	t.Parallel()
	a := assert.New(t)

	project := testutil.UniqueId()
	env := testutil.UniqueId()
	service := testutil.UniqueId()
	owner := testutil.UniqueId()

	accountID, err := strconv.ParseInt(testutil.EnvVar(testutil.EnvAccountID), 10, 0)
	a.Nil(err)

	options := testutil.Options(
		testutil.IAMRegion, // us-east-1
		map[string]interface{}{
			"project": project,
			"env":     env,
			"service": service,
			"owner":   owner,

			"aws_account_id": accountID,

			//test only
			"region":                     testutil.DefaultRegion,
			"bless_provider_aws_profile": testutil.EnvVar(testutil.EnvAWSProfile),
		},
	)

	defer testutil.Destroy(t, options, 5)
	testutil.Run(t, options)
}
