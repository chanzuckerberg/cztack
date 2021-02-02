package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSAuroraMysqlDefaults(t *testing.T) {
	t.Parallel()

	test := tftest.Test{

		Setup: func(t *testing.T) *terraform.Options {
			vpc := tftest.EnvVar(tftest.EnvVPCID)
			databaseSubnetGroup := tftest.EnvVar(tftest.EnvDatabaseSubnetGroup)
			ingressCidrBlocks := tftest.EnvVar(tftest.EnvVPCCIDRBlock)

			databasePassword := tftest.RandomString(tftest.AlphaNum, 8)
			databaseUsername := tftest.RandomString(tftest.Alpha, 8)
			databaseName := tftest.UniqueID()

			return tftest.Options(
				tftest.DefaultRegion,
				map[string]interface{}{

					"vpc_id":                vpc,
					"database_subnet_group": databaseSubnetGroup,
					"database_password":     databasePassword,
					"database_username":     databaseUsername,
					"ingress_cidr_blocks":   []string{ingressCidrBlocks},
					"database_name":         databaseName,
					"skip_final_snapshot":   true,
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
