package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSCloudWatchLogGroup(t *testing.T) {
	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			return tftest.Options(
				tftest.DefaultRegion,
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
