package role_test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAWSIAMGroupConsoleLogin(t *testing.T) {
	t.Parallel()

	region := "us-west-1"

	terraformOptions := &terraform.Options{

		TerraformDir: ".",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"group_name": random.UniqueId(),
			"iam_path":   fmt.Sprintf("/%s/", random.UniqueId()),
		},

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": region,
		}}

	defer terraform.Destroy(t, terraformOptions)

	_, err := terraform.InitAndApplyE(t, terraformOptions)

	assert.Nil(t, err)
}
