package testutil

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

type Test struct {
	Options  func(*testing.T) *terraform.Options
	Validate func(*testing.T, *terraform.Options)

	skip []string
	only []string
}

func (tt *Test) setupEnv(t *testing.T) {
	skip := ListEnvVar("SKIP")
	only := ListEnvVar("ONLY")

	if len(skip) > 0 && len(only) > 0 {
		t.Fatal("SKIP and ONLY env variables both set, you can only set one")
		return
	}
	tt.skip = skip
	tt.only = only
}

func (tt *Test) shouldRun(stage string) bool {
	if len(tt.only) > 0 {
		for _, s := range tt.only {
			if s == stage {
				return true
			}
		}
		return false
	}

	for _, s := range tt.skip {
		if s == stage {
			return false
		}
	}

	return true
}

func (tt *Test) Stage(t *testing.T, stage string, f func()) {
	if tt.shouldRun(stage) {
		t.Logf("running stage %s", stage)
		f()
	} else {
		t.Logf("skipping stage %s", stage)
	}
}

func (tt *Test) Run(t *testing.T) {
	terraformDirectory := "."

	tt.setupEnv(t)

	defer tt.Stage(t, "cleanup", func() {
		options := test_structure.LoadTerraformOptions(t, terraformDirectory)
		terraform.Destroy(t, options)
		Clean(terraformDirectory)
		test_structure.CleanupTestDataFolder(t, terraformDirectory)
	})

	tt.Stage(t, "options", func() {
		// TODO if options already exist at save point, fail?
		options := tt.Options(t)
		test_structure.SaveTerraformOptions(t, terraformDirectory, options)
	})

	tt.Stage(t, "apply", func() {
		options := test_structure.LoadTerraformOptions(t, terraformDirectory)
		terraform.InitAndApply(t, options)
	})

	tt.Stage(t, "validate", func() {
		options := test_structure.LoadTerraformOptions(t, terraformDirectory)
		tt.Validate(t, options)
	})
}
