package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSIAMInstanceProfile(t *testing.T) {
	terraformOptions := testutil.Options(
		testutil.IAMRegion,
		map[string]interface{}{
			"name_prefix":      random.UniqueId(),
			"iam_path":         "/foo/",
			"role_description": random.UniqueId(),
		},
	)

	defer terraform.Destroy(t, terraformOptions)

	testutil.Run(t, terraformOptions)
}

func TestAWSIAMInstanceProfileDisableSSM(t *testing.T) {
	terraformOptions := testutil.Options(
		testutil.IAMRegion,
		map[string]interface{}{
			"name_prefix":      random.UniqueId(),
			"iam_path":         "/foo/",
			"role_description": random.UniqueId(),
			"enable_ssm":       "false",
		},
	)

	defer terraform.Destroy(t, terraformOptions)

	testutil.Run(t, terraformOptions)
}
