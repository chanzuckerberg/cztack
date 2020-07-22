package test

import (
	"fmt"
	"testing"

	"github.com/aws/aws-sdk-go/service/ssm"
	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestGitHubWebhooks(t *testing.T) {
	test := testutil.Test{
		Options: func(t *testing.T) *terraform.Options {
			project := testutil.UniqueId()
			env := testutil.UniqueId()
			service := testutil.UniqueId()
			owner := testutil.UniqueId()

			route53ZoneID := testutil.EnvVar(testutil.EnvRoute53ZoneID)
			certArn := testutil.EnvVar(testutil.EnvWildcardCloudfrontCertARN)
			subdomain := testutil.UniqueId()
			domain := testutil.EnvVar(testutil.EnvRoute53ZoneName)

			fqdn := fmt.Sprintf("%s.%s", subdomain, domain)

			aws.PutParameter(t, testutil.DefaultRegion, fmt.Sprintf("/%s-%s-%s/%s", project, env, service, "github_secret"), "", "asdf")

			return testutil.Options(
				testutil.DefaultRegion,
				map[string]interface{}{
					"project": project,
					"env":     env,
					"service": service,
					"owner":   owner,

					"route53_zone_id": route53ZoneID,
					"certificate_arn": certArn,
					"fqdn":            fqdn,
				},
			)
		},
		// Mode:     testutil.Plan,
		Validate: func(t *testing.T, options *terraform.Options) {},
		Cleanup: func(t *testing.T, options *terraform.Options) {
			s := aws.NewSsmClient(t, testutil.DefaultRegion)
			s.DeleteParameter(&ssm.DeleteParameterInput{
				Name: testutil.Strptr(fmt.Sprintf("/%s-%s-%s/%s", options.Vars["project"], options.Vars["env"], options.Vars["service"], "github_secret")),
			})
		},
	}

	test.Run(t)
}
