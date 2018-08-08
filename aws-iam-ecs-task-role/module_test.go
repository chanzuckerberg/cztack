package test

// TODO this won't work because you can't pass JSON in as a var (it gets interpretted as HCL) https://github.com/gruntwork-io/terratest/issues/121

// package test

// import (
// 	"testing"

// 	"github.com/gruntwork-io/terratest/modules/random"
// 	"github.com/gruntwork-io/terratest/modules/terraform"
// )

// func TestTerraformBasicExample(t *testing.T) {
// 	// t.Parallel()

// 	terraformOptions := &terraform.Options{
// 		TerraformDir: ".",

// 		Vars: map[string]interface{}{
// 			"project": random.UniqueId(),
// 			"env":     random.UniqueId(),
// 			"service": random.UniqueId(),
// 			"owner":   random.UniqueId(),
// 			"policy":  "",
// 		},
// 	}

// 	defer testutil.Cleanup(t, terraformOptions)

// 	testutil.Run(t, terraformOptions)
// }
