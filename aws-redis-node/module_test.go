package test

import (
	"fmt"
	"log"
	"os"
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
)

func TestAWSRedisNode(t *testing.T) {

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

	options := testutil.Options(testutil.DefaultRegion,
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

	defer testutil.Cleanup(t, options)

	testutil.Run(t, options)
}
