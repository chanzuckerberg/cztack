package test

import (
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

	certDomainName := testutil.RandomString(testutil.Alpha, 16)

	route53ZoneID := testutil.EnvVar()

	options := testutil.Options(
		testutil.DefaultRegion,
		map[string]interface{}{
			"project": project,
			"env":     env,
			"service": service,
			"owner":   owner,

			"cert_domain_name": certDomainName,
		},
	)

	defer terraform.Destroy(t, options)
	testutil.Run(t, options)
}
