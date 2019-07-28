package terraform

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/require"
)

// InitAndPlan runs terraform init and plan with the given options and return stdout/stderr from the apply command.
func InitAndPlan(t *testing.T, options *Options) int {
	exitCode, err := InitAndPlanE(t, options)
	require.NoError(t, err)
	return exitCode
}

// InitAndPlanE runs terraform init and plan with the given options and return stdout/stderr from the apply command.
func InitAndPlanE(t *testing.T, options *Options) (int, error) {
	if _, err := InitE(t, options); err != nil {
		return DefaultErrorExitCode, err
	}

	return PlanExitCodeE(t, options)
}

// PlanExitCode runs terraform apply with the given options and returns the detailed exitcode.
func PlanExitCode(t *testing.T, options *Options) int {
	exitCode, err := PlanExitCodeE(t, options)
	require.NoError(t, err)
	return exitCode
}

// PlanExitCodeE runs terraform plan with the given options and returns the detailed exitcode.
func PlanExitCodeE(t *testing.T, options *Options) (int, error) {
	return GetExitCodeForTerraformCommandE(t, options, FormatArgs(options, "plan", "-input=false", "-lock=true", "-detailed-exitcode")...)
}

// TgPlanAllExitCode runs terragrunt plan-all with the given options and returns the detailed exitcode.
func TgPlanAllExitCode(t *testing.T, options *Options) int {
	exitCode, err := TgPlanAllExitCodeE(t, options)
	require.NoError(t, err)
	return exitCode
}

// TgPlanAllExitCodeE runs terragrunt plan-all with the given options and returns the detailed exitcode.
func TgPlanAllExitCodeE(t *testing.T, options *Options) (int, error) {
	if options.TerraformBinary != "terragrunt" {
		return 1, fmt.Errorf("terragrunt must be set as TerraformBinary to use this method")
	}

	return GetExitCodeForTerraformCommandE(t, options, FormatArgs(options, "plan-all", "--input=false", "--lock=true", "--detailed-exitcode")...)
}
