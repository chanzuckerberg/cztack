package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSAurora(t *testing.T) {
	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			return tftest.Options(
				tftest.DefaultRegion,
				map[string]interface{}{
					"database_name":  tftest.UniqueID(),
					"engine_version": "10.7",
					"port":           "5432",
					"engine":         "aurora-postgresql",
					"vpc_id":         "vpc-12345",

					"project":               tftest.UniqueID(),
					"service":               tftest.UniqueID(),
					"env":                   tftest.UniqueID(),
					"owner":                 tftest.UniqueID(),
					"database_username":     tftest.UniqueID(),
					"database_password":     tftest.UniqueID(),
					"database_subnet_group": tftest.UniqueID(),
				},
			)
		},

		Mode: tftest.Plan,

		Validate: func(t *testing.T, options *terraform.Options) {},
	}
	test.Run(t)
}
