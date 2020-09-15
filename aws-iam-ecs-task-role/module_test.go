package test

// TODO this won't work because you can't pass JSON in as a var (it gets interpretted as HCL) https://github.com/gruntwork-io/terratest/issues/121

// package test

// import (
// 	"testing"

// 	"github.com/gruntwork-io/terratest/modules/random"
// 	"github.com/gruntwork-io/terratest/modules/terraform"
// )

// func TestTerraformBasicExample(t *testing.T) {

// 	terraformOptions := &terraform.Options{
// 		TerraformDir: ".",

// 		Vars: map[string]interface{}{
// 			"project": random.UniqueID(),
// 			"env":     random.UniqueID(),
// 			"service": random.UniqueID(),
// 			"owner":   random.UniqueID(),
// 			"policy":  "",
// 		},
// 	}

// 	defer tftest.Cleanup(t, terraformOptions)

// 	tftest.Run(t, terraformOptions)
// }
