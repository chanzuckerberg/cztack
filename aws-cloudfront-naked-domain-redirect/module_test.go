package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestModule(t *testing.T) {
	t.Skip("remove this for real tests")
	test := tftest.Test{
		Setup:    func(t *testing.T) *terraform.Options { return nil },
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
