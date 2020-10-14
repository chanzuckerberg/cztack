package test

import (
	"testing"
)

func TestModule(t *testing.T) {
	t.Skip(`
	We need to configure a custom provider to use this module.
	Terratest does not make it easy to do,
	therefore actual tests live in ./test`)
}
