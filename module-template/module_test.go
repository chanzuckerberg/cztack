package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestModule(t *testing.T) {
	t.Skip("remove this for real tests")
	test := testutil.Test{
		Options:  func(t *testing.T) *terraform.Options { return nil },
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
