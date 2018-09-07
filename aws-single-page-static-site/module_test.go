package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAwsSinglePageStaticSiteInit(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}

func TestAwsSinglePageStaticSiteInitAndApply(t *testing.T) {
	t.Parallel()
	project := testutil.UniqueId()
	env := testutil.UniqueId()
	service := testutil.UniqueId()
	owner := testutil.UniqueId()

	subdomain := testutil.UniqueId()
	awsACMCert := testutil.EnvVar(testutil.EnvWildcardCloudfrontCertARN)
	route53ZoneID := testutil.EnvVar(testutil.EnvRoute53ZoneID)

	aliases := []string{fmt.Sprintf(
		"%s.%s",
		testutil.UniqueId(),
		testutil.EnvVar(testutil.EnvRoute53ZoneName))}

	options := testutil.Options(
		testutil.IAMRegion, // us-east-1
		map[string]interface{}{
			"project": project,
			"env":     env,
			"service": service,
			"owner":   owner,

			"subdomain":           subdomain,
			"aws_acm_cert_arn":    awsACMCert,
			"aws_route53_zone_id": route53ZoneID,
			"aliases":             aliases,
		},
	)

	defer testutil.Destroy(t, options, 5)
	testutil.Run(t, options)
}
