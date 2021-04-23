package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestAll(t *testing.T) {
	r := require.New(t)

	terraformOptions := &terraform.Options{
		TerraformDir: ".",

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": "us-east-1",
		},

		Vars: map[string]interface{}{
			"restrict": "all",
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// HACK(el): Since this resource is account-wide, there are race-conditions on the actual AWS resource.
	//           Instead we test the configuration outputs here.
	output, err := terraform.OutputMapE(t, terraformOptions, "block_settings")
	r.NoError(err)

	r.Equal("true", output["block_public_acls"])
	r.Equal("true", output["block_public_policy"])
	r.Equal("true", output["ignore_public_acls"])
	r.Equal("true", output["restrict_public_buckets"])
}

func TestNone(t *testing.T) {
	r := require.New(t)

	terraformOptions := &terraform.Options{
		TerraformDir: ".",

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": "us-east-1",
		},

		Vars: map[string]interface{}{
			"restrict": "none",
		},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	output, err := terraform.OutputMapE(t, terraformOptions, "block_settings")
	r.NoError(err)

	r.Equal("false", output["block_public_acls"])
	r.Equal("false", output["block_public_policy"])
	r.Equal("false", output["ignore_public_acls"])
	r.Equal("false", output["restrict_public_buckets"])
}

func TestNew(t *testing.T) {
	r := require.New(t)

	terraformOptions := &terraform.Options{
		TerraformDir: ".",

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": "us-east-1",
		},

		Vars: map[string]interface{}{
			"restrict": "new",
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	output, err := terraform.OutputMapE(t, terraformOptions, "block_settings")
	r.NoError(err)

	r.Equal("true", output["block_public_acls"])
	r.Equal("true", output["block_public_policy"])
	r.Equal("false", output["ignore_public_acls"])
	r.Equal("false", output["restrict_public_buckets"])
}
