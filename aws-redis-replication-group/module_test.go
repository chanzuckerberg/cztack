package test

import (
	"fmt"
	"log"
	"os"
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSRedisReplicationGroup(t *testing.T) {
	test := tftest.Test{

		Setup: func(t *testing.T) *terraform.Options {
			privateSubnets := tftest.ListEnvVar("PRIVATE_SUBNETS")
			log.Printf("subnets %#v\n", privateSubnets)
			log.Printf("subnets %#v\n", os.Getenv("PRIVATE_SUBNETS"))
			vpc := tftest.EnvVar(tftest.EnvVPCID)

			sg := tftest.CreateSecurityGroup(t, tftest.DefaultRegion, vpc)

			project := tftest.UniqueID()
			env := tftest.UniqueID()
			service := tftest.UniqueID()
			owner := tftest.UniqueID()
			replication_group_description := tftest.UniqueID()
			transit_encryption_enabled := true
			at_rest_encryption_enabled := true

			az := fmt.Sprintf("%sa", tftest.DefaultRegion)

			return tftest.Options(tftest.DefaultRegion,
				map[string]interface{}{
					"tags": map[string]string{
						"project":   project,
						"env":       env,
						"service":   service,
						"owner":     owner,
						"managedBy": "terraform",
					},

					"preferred_cache_cluster_azs": []string{az},
					"subnets":                     privateSubnets,
					"ingress_security_group_ids":  []string{sg},
					"vpc_id":                      vpc,

					"description":                replication_group_description,
					"transit_encryption_enabled": transit_encryption_enabled,
					"at_rest_encryption_enabled": at_rest_encryption_enabled,
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
