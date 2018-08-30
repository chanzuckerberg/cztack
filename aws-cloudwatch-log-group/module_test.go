package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSCloudWatchLogGroup(t *testing.T) {
	options := testutil.Options(
		testutil.DefaultRegion,
		map[string]interface{}{
			"project":        random.UniqueId(),
			"env":            random.UniqueId(),
			"service":        random.UniqueId(),
			"owner":          random.UniqueId(),
			"log_group_name": random.UniqueId(),
		},
	)
	defer terraform.Destroy(t, options)
	testutil.Run(t, options)
}
