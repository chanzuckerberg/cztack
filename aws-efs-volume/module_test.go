package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestEfsVolume(t *testing.T) {
	test := tftest.Test{
		Setup: func(t *testing.T) *terraform.Options {
			project := tftest.UniqueId()
			env := tftest.UniqueId()
			service := tftest.UniqueId()
			owner := tftest.UniqueId()

			volumeName := tftest.UniqueId()

			return tftest.Options(
				tftest.DefaultRegion,
				map[string]interface{}{
					"project": project,
					"env":     env,
					"service": service,
					"owner":   owner,

					"volume_name": volumeName,
					"vpc_id":      tftest.EnvVar(tftest.EnvVPCID),
					"subnet_ids":  tftest.ListEnvVar("PRIVATE_SUBNETS"),
				},
			)
		},
		Validate: func(t *testing.T, options *terraform.Options) {},
	}

	test.Run(t)
}
