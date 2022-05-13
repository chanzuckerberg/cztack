package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSAuroraPostgresInit(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}

func TestAWSAuroraPostgresDefaults(t *testing.T) {
	versions := []string{"10.14", "11.15"}

	for _, version := range versions {
		v := version
		t.Run(version, func(t *testing.T) {
			test := tftest.Test{
				Setup: func(t *testing.T) *terraform.Options {
					project := tftest.UniqueID()
					env := tftest.UniqueID()
					service := tftest.UniqueID()
					owner := tftest.UniqueID()

					vpc := tftest.EnvVar(tftest.EnvVPCID)
					databaseSubnetGroup := tftest.EnvVar(tftest.EnvDatabaseSubnetGroup)
					ingressCidrBlocks := tftest.EnvVar(tftest.EnvVPCCIDRBlock)

					databasePassword := tftest.RandomString(tftest.AlphaNum, 8)
					databaseUsername := tftest.RandomString(tftest.Alpha, 8)
					databaseName := tftest.UniqueID()

					return tftest.Options(
						tftest.DefaultRegion,
						map[string]interface{}{
							"project": project,
							"env":     env,
							"service": service,
							"owner":   owner,

							"vpc_id":                vpc,
							"database_subnet_group": databaseSubnetGroup,
							"database_password":     databasePassword,
							"database_username":     databaseUsername,
							"ingress_cidr_blocks":   []string{ingressCidrBlocks},
							"database_name":         databaseName,
							"skip_final_snapshot":   true,
							"engine_version":        v,
						},
					)
				},
				Validate: func(t *testing.T, options *terraform.Options) {},
			}

			test.Run(t)
		})
	}
}
