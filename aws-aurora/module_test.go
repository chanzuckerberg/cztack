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
					"database_name":         tftest.UniqueId(),
					"engine_version":        "10.7",
					"params_engine_version": "10",
					"port":                  "5432",
					"engine":                "aurora-postgresql",
					"vpc_id":                "vpc-12345",

					"project":               tftest.UniqueId(),
					"service":               tftest.UniqueId(),
					"env":                   tftest.UniqueId(),
					"owner":                 tftest.UniqueId(),
					"database_username":     tftest.UniqueId(),
					"database_password":     tftest.UniqueId(),
					"database_subnet_group": tftest.UniqueId(),
				},
			)
		},

		Mode: tftest.Plan,

		Validate: func(t *testing.T, options *terraform.Options) {},
	}
	test.Run(t)
}
