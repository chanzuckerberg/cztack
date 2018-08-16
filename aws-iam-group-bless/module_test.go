package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSIAMGroupBless(t *testing.T) {
	// t.Parallel()

	terraformOptions := &terraform.Options{

		TerraformDir: ".",

		Vars: map[string]interface{}{
			"principal_name": random.UniqueId(),
			"iam_path":       fmt.Sprintf("/%s/", random.UniqueId()),
		},

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": testutil.IAMRegion,
		}}

	defer testutil.Cleanup(t, terraformOptions)

	testutil.Run(t, terraformOptions)
}
