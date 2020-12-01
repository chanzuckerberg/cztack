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
			return tftest.Options(
				tftest.DefaultRegion,
				map[string]interface{}{
					"database_name": "database",
					"schema_name":   "schema",
					"table_name":    "table",
					"roles":         []string{"a", "b", "c"},
					"shares":        []string{"as", "bs", "cs"},
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
