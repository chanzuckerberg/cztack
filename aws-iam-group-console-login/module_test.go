package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSIAMGroupConsoleLogin(t *testing.T) {
	test := testutil.Test{
		Options: func(t *testing.T) *terraform.Options {
			return testutil.Options(
				testutil.IAMRegion,

				map[string]interface{}{
					"group_name": random.UniqueId(),
					"iam_path":   fmt.Sprintf("/%s/", random.UniqueId()),
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
