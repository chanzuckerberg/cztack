package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAwsSinglePageStaticSite(t *testing.T) {
	t.Parallel()

	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			subdomain := tftest.UniqueID()
			route53ZoneID := tftest.EnvVar(tftest.EnvRoute53ZoneID)

			options := tftest.Options(
				"us-east-1", // tftest.DefaultRegion is us-west-2, so we have to hardcode this value
				map[string]interface{}{
					"subdomain":           subdomain,
					"aws_route53_zone_id": route53ZoneID,
				},
			)
			options.TerraformDir = "./test"
			return options
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
