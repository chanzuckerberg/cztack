package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSACMCertificateInit(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}

func TestAWSACMCertificateDefaults(t *testing.T) {
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

			tags := map[string]string{
				"project":   tftest.UniqueID(),
				"env":       tftest.UniqueID(),
				"service":   tftest.UniqueID(),
				"owner":     tftest.UniqueID(),
				"managedBy": "terraform",
			}

			vars := map[string]interface{}{
				"cert_domain_name":               certDomainName,
				"aws_route53_zone_id":            route53ZoneID,
				"validation_record_ttl":          5,
				"cert_subject_alternative_names": alternativeNames,
				"tags":                           tags,
			}

			options := &terraform.Options{
				TerraformDir: ".",

				EnvVars: map[string]string{
					"AWS_DEFAULT_REGION": tftest.DefaultRegion,
				},

				Vars: vars,
			}

			return options
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
