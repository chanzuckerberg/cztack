package testutil

import (
	"errors"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/require"
)

type TestMode int

const (
	Apply TestMode = 0
	Plan  TestMode = 1
	Init  TestMode = 2
)

type Test struct {
	Options  func(*testing.T) *terraform.Options
	Validate func(*testing.T, *terraform.Options)
	Cleanup  func(*testing.T, *terraform.Options)

	Mode TestMode

	skip []string
	only []string
}

func (tt *Test) validate() error {
	if tt.Options == nil {
		return errors.New("Options must be set")
	}

	if tt.Validate == nil {
		return errors.New("Validate must be set")
	}
	return nil
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
	r := require.New(t)

	terraformDirectory := "."

	err := tt.validate()
	r.NoError(err)

	tt.setupEnv(t)

	defer tt.Stage(t, "cleanup", func() {
		options := test_structure.LoadTerraformOptions(t, terraformDirectory)
		terraform.DestroyE(t, options) //nolint
		Clean(terraformDirectory)
		test_structure.CleanupTestDataFolder(t, terraformDirectory)
		if tt.Cleanup != nil {
			tt.Cleanup(t, options)
		}
	})

	tt.Stage(t, "options", func() {
		fileExists := func(filename string) bool {
			info, err := os.Stat(filename)
			if os.IsNotExist(err) {
				return false
			}
			return !info.IsDir()
		}

		if fileExists(test_structure.FormatTestDataPath(terraformDirectory, "TerraformOptions.json")) {
			t.Log("options file exists, skipping generation")
			return
		}
		options := tt.Options(t)
		test_structure.SaveTerraformOptions(t, terraformDirectory, options)
	})

	tt.Stage(t, "apply", func() {
		r := require.New(t)
		options := test_structure.LoadTerraformOptions(t, terraformDirectory)
		switch tt.Mode {
		case Apply:
			terraform.InitAndApply(t, options)
		case Plan:
			rc, err := terraform.InitAndPlanWithExitCodeE(t, options)
			r.NoError(err)
			r.Equal(2, rc)
		case Init:
			terraform.Init(t, options)
		}
	})

	tt.Stage(t, "validate", func() {
		options := test_structure.LoadTerraformOptions(t, terraformDirectory)
		tt.Validate(t, options)
	})
}
