package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestIAMRoleBless(t *testing.T) {
	t.Parallel()

	region := "us-west-1"
	curAcct := testutil.AWSCurrentAccountId(t)

	terraformOptions := &terraform.Options{
		TerraformDir: ".",

		Vars: map[string]interface{}{
			"role_name":         random.UniqueId(),
			"source_account_id": curAcct,
			"bless_lambda_arns": []string{},
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": region,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	_, err := terraform.InitAndApplyE(t, terraformOptions)

	assert.Nil(t, err)
}
