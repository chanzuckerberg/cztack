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

func TestAWSAuroraPostgresInitAndApply(t *testing.T) {
	t.Parallel()
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

	options := testutil.Options(
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
		},
	)
	defer terraform.Destroy(t, options)
	testutil.Run(t, options)
}
