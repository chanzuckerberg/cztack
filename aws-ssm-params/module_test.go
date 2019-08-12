package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWSSSMParams(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: ".",
	}
	terraform.Init(t, options)
}
