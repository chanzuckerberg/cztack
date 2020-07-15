package test

import (
	"fmt"
	"log"
	"os"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSRedisNode(t *testing.T) {

	test := testutil.Test{
		Options: func(t *testing.T) *terraform.Options {
			privateSubnets := testutil.ListEnvVar("PRIVATE_SUBNETS")
			log.Printf("subnets %#v\n", privateSubnets)
			log.Printf("subnets %#v\n", os.Getenv("PRIVATE_SUBNETS"))
			vpc := testutil.EnvVar(testutil.EnvVPCID)

			sg := testutil.CreateSecurityGroup(t, testutil.DefaultRegion, vpc)
			defer testutil.DeleteSecurityGroup(t, testutil.DefaultRegion, sg)

			project := testutil.UniqueId()
			env := testutil.UniqueId()
			service := testutil.UniqueId()
			owner := testutil.UniqueId()

			az := fmt.Sprintf("%sa", testutil.DefaultRegion)

			return testutil.Options(testutil.DefaultRegion,
				map[string]interface{}{
					"project": project,
					"env":     env,
					"service": service,
					"owner":   owner,

					"availability_zone":          az,
					"subnets":                    privateSubnets,
					"ingress_security_group_ids": []string{sg},
					"vpc_id":                     vpc,
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
