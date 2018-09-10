package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAwsIamEcsTaskRoleInit(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}

func TestAwsIamEcsTaskRoleValidation(t *testing.T) {
	a := assert.New(t)

	data := []struct {
		policy_text string
		policy_arn  string
	}{
		{"{}", "foo"},
		{"", ""},
	}

	for _, test := range data {
		t.Run("", func(t *testing.T) {
			project := testutil.UniqueId()
			env := testutil.UniqueId()
			service := testutil.UniqueId()
			owner := testutil.UniqueId()

			options := testutil.Options(
				testutil.DefaultRegion,
				map[string]interface{}{
					"project": project,
					"env":     env,
					"service": service,
					"owner":   owner,

					"policy_text": test.policy_text,
					"policy_arn":  test.policy_arn,
				},
			)
			defer terraform.DestroyE(t, options)
			output, e := terraform.InitAndApplyE(t, options)
			a.NotNil(e)
			a.Contains(output, "You may set one of `var.policy_text` or `var.policy_arn` but not both.")
		})
	}
}
