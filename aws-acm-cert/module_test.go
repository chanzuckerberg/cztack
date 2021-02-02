package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSACMCertInit(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}

func TestAWSACMCertDefaults(t *testing.T) {
	t.Parallel()

	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			certDomainName := fmt.Sprintf(
				"%s.%s",
				tftest.UniqueID(),
				tftest.EnvVar(tftest.EnvRoute53ZoneName))

			alternativeDomainName := fmt.Sprintf(
				"%s.%s",
				tftest.UniqueID(),
				tftest.EnvVar(tftest.EnvRoute53ZoneName))

			route53ZoneID := tftest.EnvVar(tftest.EnvRoute53ZoneID)

			alternativeNames := map[string]string{
				alternativeDomainName: route53ZoneID,
			}

			return tftest.Options(
				tftest.DefaultRegion,
				map[string]interface{}{
					"cert_domain_name":                     certDomainName,
					"aws_route53_zone_id":                  route53ZoneID,
					"validation_record_ttl":                5,
					"cert_subject_alternative_names":       alternativeNames,
					"cert_subject_alternative_names_count": len(alternativeNames),
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
