package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestModule(t *testing.T) {
	test := tftest.Test{
		// just run init, swtich to Plan or Apply when you can
		Mode: tftest.Init,

		Setup: func(t *testing.T) *terraform.Options {
			vars := map[string]interface{}{
				"database_name": "database",
				"schema_name":   "schema",
				"table_name":    "table",
				"roles":         []string{"a", "b", "c"},
				"shares":        []string{"as", "bs", "cs"},
			}

			opts := &terraform.Options{
				TerraformDir: ".",

				EnvVars: map[string]string{
					"AWS_DEFAULT_REGION": tftest.DefaultRegion,
				},

				Vars: vars,
			}

			return opts
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
