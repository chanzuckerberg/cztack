package role_test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestTerraformBasicExample(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{

		// The path to where our Terraform code is located
		TerraformDir: ".",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"group_name": random.UniqueId(),
			"iam_path":   fmt.Sprintf("/%s/", random.UniqueId()),
		},

		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	_, err := terraform.InitAndApplyE(t, terraformOptions)

	assert.Nil(t, err)

	// Run `terraform output` to get the value of an output variable
	// terraform.Output(t, terraformOptions, "example")

	// Verify we're getting back the variable we expect
	// assert.Equal(t, expectedText, actualText)
}
