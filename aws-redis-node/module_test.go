package test

import (
	"fmt"
	"log"
	"os"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSRedisNode(t *testing.T) {
	test := tftest.Test{

		Setup: func(t *testing.T) *terraform.Options {
			privateSubnets := tftest.ListEnvVar("PRIVATE_SUBNETS")
			log.Printf("subnets %#v\n", privateSubnets)
			log.Printf("subnets %#v\n", os.Getenv("PRIVATE_SUBNETS"))
			vpc := tftest.EnvVar(tftest.EnvVPCID)

			sg := tftest.CreateSecurityGroup(t, tftest.DefaultRegion, vpc)

			az := fmt.Sprintf("%sa", tftest.DefaultRegion)

			return tftest.Options(tftest.DefaultRegion,
				map[string]interface{}{

					"availability_zone":          az,
					"subnets":                    privateSubnets,
					"ingress_security_group_ids": []string{sg},
					"vpc_id":                     vpc,
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},

		Cleanup: func(t *testing.T, options *terraform.Options) {
			tftest.DeleteSecurityGroup(t, tftest.DefaultRegion, options.Vars["ingress_security_group_ids"].([]interface{})[0].(string))
		},
	}

	test.Run(t)
}
