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

func TestAWSACMCertInitAndApply(t *testing.T) {
	t.Parallel()
	project := testutil.UniqueId()
	env := testutil.UniqueId()
	service := testutil.UniqueId()
	owner := testutil.UniqueId()

	certDomainName := fmt.Sprintf(
		"%s.%s",
		testutil.UniqueId(),
		testutil.EnvVar(testutil.EnvRoute53ZoneName))

	route53ZoneID := testutil.EnvVar(testutil.EnvRoute53ZoneID)

	options := testutil.Options(
		testutil.DefaultRegion,
		map[string]interface{}{
			"project": project,
			"env":     env,
			"service": service,
			"owner":   owner,

			"cert_domain_name":      certDomainName,
			"aws_route53_zone_id":   route53ZoneID,
			"validation_record_ttl": 5,
		},
	)

	defer terraform.Destroy(t, options)
	testutil.Run(t, options)
}
