package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
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

	test := testutil.Test{
		Options: func(t *testing.T) *terraform.Options {
			project := testutil.UniqueId()
			env := testutil.UniqueId()
			service := testutil.UniqueId()
			owner := testutil.UniqueId()

			certDomainName := fmt.Sprintf(
				"%s.%s",
				testutil.UniqueId(),
				testutil.EnvVar(testutil.EnvRoute53ZoneName))

			alternativeDomainName := fmt.Sprintf(
				"%s.%s",
				testutil.UniqueId(),
				testutil.EnvVar(testutil.EnvRoute53ZoneName))

			route53ZoneID := testutil.EnvVar(testutil.EnvRoute53ZoneID)

			alternativeNames := map[string]string{
				alternativeDomainName: route53ZoneID,
			}

			return testutil.Options(
				testutil.DefaultRegion,
				map[string]interface{}{
					"project": project,
					"env":     env,
					"service": service,
					"owner":   owner,

					"cert_domain_name":               certDomainName,
					"aws_route53_zone_id":            route53ZoneID,
					"validation_record_ttl":          5,
					"cert_subject_alternative_names": alternativeNames,
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
