package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestModule(t *testing.T) {
	test := tftest.Test{
		// Destroying lambda@edge lambdas requires manual work, so skip and let GC clean up
		SkipDestroy: true,
		Setup: func(t *testing.T) *terraform.Options {
			route53Zone := tftest.EnvVar(tftest.EnvRoute53ZoneName)
			targetSubdomain := tftest.UniqueID()

			project := tftest.UniqueID()
			env := tftest.UniqueID()
			service := tftest.UniqueID()
			owner := tftest.UniqueID()

			target_domain := fmt.Sprintf("%s.%s", targetSubdomain, route53Zone)
			source_domain := fmt.Sprintf("%s.%s", tftest.UniqueID(), route53Zone)
			source_domain_zone_id := tftest.EnvVar(tftest.EnvRoute53ZoneID)

			return tftest.Options(
				tftest.IAMRegion,
				map[string]interface{}{
					"target_domain":         target_domain,
					"source_domain":         source_domain,
					"source_domain_zone_id": source_domain_zone_id,

					"project": project,
					"env":     env,
					"service": service,
					"owner":   owner,
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
