package test

import (
	"fmt"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
)

func TestAwsSinglePageStaticSite(t *testing.T) {
	t.Parallel()
	project := tftest.UniqueID()
	env := tftest.UniqueID()
	service := tftest.UniqueID()
	owner := tftest.UniqueID()

	subdomain := tftest.UniqueID()
	awsACMCert := tftest.EnvVar(tftest.EnvWildcardCloudfrontCertARN)
	route53ZoneID := tftest.EnvVar(tftest.EnvRoute53ZoneID)

	aliases := []string{fmt.Sprintf(
		"%s.%s",
		tftest.UniqueID(),
		tftest.EnvVar(tftest.EnvRoute53ZoneName))}

	options := tftest.Options(
		tftest.IAMRegion, // us-east-1
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

	// defer tftest.Destroy(t, options, 5)
	tftest.Run(t, options)
}
