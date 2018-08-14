package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSCloudWatchLogGroup(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
		Vars: map[string]interface{}{
			"project":        random.UniqueId(),
			"env":            random.UniqueId(),
			"service":        random.UniqueId(),
			"owner":          random.UniqueId(),
			"log_group_name": random.UniqueId(),
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": testutil.DefaultRegion,
		},
	}
	defer terraform.Destroy(t, options)
	terraform.InitAndApply(t, options)
}
