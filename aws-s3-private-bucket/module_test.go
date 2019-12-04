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

	bucketName := testutil.UniqueId()

	options := testutil.Options(
		testutil.DefaultRegion,
		map[string]interface{}{
			"project": project,
			"env":     env,
			"service": service,
			"owner":   owner,

			"bucket_name": bucketName,
		},
	)

	defer terraform.Destroy(t, options)
	testutil.Run(t, options)
}
