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

	private_subnets := testutil.ListEnvVar("PRIVATE_SUBNETS")
	log.Printf("subnets %#v\n", private_subnets)
	log.Printf("subnets %#v\n", os.Getenv("PRIVATE_SUBNETS"))
	vpc := testutil.EnvVar("VPC_ID")

	sg := testutil.CreateSecurityGroup(t, testutil.DefaultRegion, vpc)
	defer testutil.DeleteSecurityGroup(t, testutil.DefaultRegion, sg)

	project := testutil.UniqueId()
	env := testutil.UniqueId()
	service := testutil.UniqueId()
	owner := testutil.UniqueId()

	az := fmt.Sprintf("%sa", testutil.DefaultRegion)

	options := &terraform.Options{
		TerraformDir: ".",

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": testutil.DefaultRegion,
		},

		Vars: map[string]interface{}{
			"project": project,
			"env":     env,
			"service": service,
			"owner":   owner,

			"availability_zone":          az,
			"subnets":                    private_subnets,
			"ingress_security_group_ids": []string{sg},
		},
	}

	defer testutil.Cleanup(t, options)

	testutil.Run(t, options)
}
