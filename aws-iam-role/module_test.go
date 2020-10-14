package test

import (
	"testing"

	"github.com/chanzuckerberg/go-misc/tftest"
)

func TestAWSIAMROle(t *testing.T) {
	roleName := tftest.CreateRole(t)
	project := tftest.UniqueID()
	env := tftest.UniqueID()
	service := tftest.UniqueID()
	owner := tftest.UniqueID()

	principals := []interface{}{
		map[string]interface{}{
			"type":        "Service",
			"identifiers": []string{"firehose.amazonaws.com"},
		},
	}

	defer tftest.DeleteRole(t, roleName) //nolint

	terraformOptions := tftest.Options(
		tftest.IAMRegion,
		map[string]interface{}{
			"role_name":  roleName,
			"project":    project,
			"env":        env,
			"service":    service,
			"owner":      owner,
			"principals": principals,
		},
	)

	defer tftest.Cleanup(t, terraformOptions)

	tftest.Run(t, terraformOptions)
}
