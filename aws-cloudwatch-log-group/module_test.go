package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSCloudWatchLogGroup(t *testing.T) {

	test := testutil.Test{
		Options: func(t *testing.T) *terraform.Options {
			return testutil.Options(
				testutil.DefaultRegion,
				map[string]interface{}{
					"project":        random.UniqueId(),
					"env":            random.UniqueId(),
					"service":        random.UniqueId(),
					"owner":          random.UniqueId(),
					"log_group_name": random.UniqueId(),
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
