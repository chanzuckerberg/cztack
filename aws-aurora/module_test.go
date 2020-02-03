package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAWSAurora(t *testing.T) {
	a := assert.New(t)
	options := testutil.Options(
		testutil.DefaultRegion,
		map[string]interface{}{
			"database_name":         testutil.UniqueId(),
			"engine_version":        "10.7",
			"params_engine_version": "10",
			"port":                  "5432",
			"engine":                "aurora-postgresql",
			"vpc_id":                "vpc-12345",

			"project":               testutil.UniqueId(),
			"service":               testutil.UniqueId(),
			"env":                   testutil.UniqueId(),
			"owner":                 testutil.UniqueId(),
			"database_username":     testutil.UniqueId(),
			"database_password":     testutil.UniqueId(),
			"database_subnet_group": testutil.UniqueId(),
		},
	)

	rc, e := terraform.InitAndPlanE(t, options)
	a.NoError(e)
	a.Equal(2, rc) // 2 means planned changes, no errors
}
