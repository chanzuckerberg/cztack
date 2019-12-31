package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestPrivateBucket(t *testing.T) {

	project := testutil.UniqueId()
	env := testutil.UniqueId()
	service := testutil.UniqueId()
	owner := testutil.UniqueId()
	vpcId := testutil.UniqueId()

	volumeName := testutil.UniqueId()

	options := testutil.Options(
		testutil.DefaultRegion,
		map[string]interface{}{
			"project": project,
			"env":     env,
			"service": service,
			"owner":   owner,

			"volume_name": volumeName,
			"vpc_id": vpcId,
		},
	)

	defer terraform.Destroy(t, options)
	testutil.Run(t, options)
}
