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

	vpc := testutil.EnvVar("VPC_ID")
	database_subnet_group := testutil.EnvVar("DATABASE_SUBNET_GROUP")
	ingress_cidr_blocks := testutil.EnvVar("VPC_CIDR_BLOCK")

	database_password := testutil.RandomString(testutil.AlphaNum, 8)
	database_username := testutil.RandomString(testutil.Alpha, 8)
	database_name := testutil.UniqueId()

	options := testutil.Options(
		testutil.DefaultRegion,
		map[string]interface{}{
			"project": project,
			"env":     env,
			"service": service,
			"owner":   owner,

			"vpc_id":                vpc,
			"database_subnet_group": database_subnet_group,
			"database_password":     database_password,
			"database_username":     database_username,
			"ingress_cidr_blocks":   []string{ingress_cidr_blocks},
			"database_name":         database_name,
			"skip_final_snapshot":   true,
		},
	)
	defer terraform.Destroy(t, options)
	testutil.Run(t, options)
}
