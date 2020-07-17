package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSAuroraPostgresInit(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}

func TestAWSAuroraPostgresDefaults(t *testing.T) {
	t.Parallel()
	versions := []string{"9.6", "10.12", "11.7"}

	for _, version := range versions {
		t.Run(version, func(t *testing.T) {
			test := testutil.Test{
				Options: func(t *testing.T) *terraform.Options {
					project := testutil.UniqueId()
					env := testutil.UniqueId()
					service := testutil.UniqueId()
					owner := testutil.UniqueId()

					vpc := testutil.EnvVar(testutil.EnvVPCID)
					databaseSubnetGroup := testutil.EnvVar(testutil.EnvDatabaseSubnetGroup)
					ingressCidrBlocks := testutil.EnvVar(testutil.EnvVPCCIDRBlock)

					databasePassword := testutil.RandomString(testutil.AlphaNum, 8)
					databaseUsername := testutil.RandomString(testutil.Alpha, 8)
					databaseName := testutil.UniqueId()

					return testutil.Options(
						testutil.DefaultRegion,
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
							"engine_version":        version,
						},
					)

				},
				Validate: func(t *testing.T, options *terraform.Options) {},
			}

			test.Run(t)
		})
	}
}
