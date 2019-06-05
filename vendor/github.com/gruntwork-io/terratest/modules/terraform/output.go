package terraform

import (
	"encoding/json"
	"fmt"
	"reflect"
	"strings"
	"testing"

	"github.com/stretchr/testify/require"
)

// Output calls terraform output for the given variable and return its value.
func Output(t *testing.T, options *Options, key string) string {
	out, err := OutputE(t, options, key)
	require.NoError(t, err)
	return out
}

// OutputE calls terraform output for the given variable and return its value.
func OutputE(t *testing.T, options *Options, key string) (string, error) {
	output, err := RunTerraformCommandE(t, options, "output", "-no-color", key)

	if err != nil {
		return "", err
	}

	return strings.TrimSpace(output), nil
}

// OutputRequired calls terraform output for the given variable and return its value. If the value is empty, fail the test.
func OutputRequired(t *testing.T, options *Options, key string) string {
	out, err := OutputRequiredE(t, options, key)
	require.NoError(t, err)
	return out
}

// OutputRequiredE calls terraform output for the given variable and return its value. If the value is empty, return an error.
func OutputRequiredE(t *testing.T, options *Options, key string) (string, error) {
	out, err := OutputE(t, options, key)

	if err != nil {
		return "", err
	}
	if out == "" {
		return "", EmptyOutput(key)
	}

	return out, nil
}

// OutputList calls terraform output for the given variable and returns its value as a list.
// If the output value is not a list type, then it fails the test.
func OutputList(t *testing.T, options *Options, key string) []string {
	out, err := OutputListE(t, options, key)
	require.NoError(t, err)
	return out
}

// OutputListE calls terraform output for the given variable and returns its value as a list.
// If the output value is not a list type, then it returns an error.
func OutputListE(t *testing.T, options *Options, key string) ([]string, error) {
	out, err := RunTerraformCommandE(t, options, "output", "-no-color", "-json", key)
	if err != nil {
		return nil, err
	}

	var output interface{}
	if err := json.Unmarshal([]byte(out), &output); err != nil {
		return nil, err
	}

	if outputMap, isMap := output.(map[string]interface{}); isMap {
		return parseListOutputTerraform11OrOlder(outputMap, key)
	} else if outputList, isList := output.([]interface{}); isList {
		return parseListOutputTerraform12OrNewer(outputList, key)
	}

	return nil, UnexpectedOutputType{Key: key, ExpectedType: "map or list", ActualType: reflect.TypeOf(output).String()}
}

// Parse a list output in the format it is returned by Terraform 0.12 and newer versions
func parseListOutputTerraform12OrNewer(outputList []interface{}, key string) ([]string, error) {
	list := []string{}

	for _, item := range outputList {
		list = append(list, fmt.Sprintf("%v", item))
	}

	return list, nil
}

// Parse a list output in the format it is returned by Terraform 0.11 and older versions
func parseListOutputTerraform11OrOlder(outputMap map[string]interface{}, key string) ([]string, error) {
	value, containsValue := outputMap["value"]
	if !containsValue {
		return nil, OutputKeyNotFound(key)
	}

	list := []string{}
	switch t := value.(type) {
	case []interface{}:
		for _, item := range t {
			list = append(list, fmt.Sprintf("%v", item))
		}
	default:
		return nil, OutputValueNotList{Value: value}
	}

	return list, nil
}

// OutputMap calls terraform output for the given variable and returns its value as a map.
// If the output value is not a map type, then it fails the test.
func OutputMap(t *testing.T, options *Options, key string) map[string]string {
	out, err := OutputMapE(t, options, key)
	require.NoError(t, err)
	return out
}

// OutputMapE calls terraform output for the given variable and returns its value as a map.
// If the output value is not a map type, then it returns an error.
func OutputMapE(t *testing.T, options *Options, key string) (map[string]string, error) {
	out, err := RunTerraformCommandE(t, options, "output", "-no-color", "-json", key)
	if err != nil {
		return nil, err
	}

	outputMap := map[string]interface{}{}
	if err := json.Unmarshal([]byte(out), &outputMap); err != nil {
		return nil, err
	}

	// Terraform 0.11 or older return an object where the value we want is under the key "value". Terraform 0.12 and
	// older return the value we want directly.
	value, containsValue := outputMap["value"]
	_, containsSensitive := outputMap["sensitive"]
	_, containsType := outputMap["type"]
	if containsValue && containsSensitive && containsType {
		// Handle Terraform 0.11 and older
		valueMap, ok := value.(map[string]interface{})
		if !ok {
			return nil, OutputValueNotMap{Value: value}
		}

		outputMap = valueMap
	}

	resultMap := make(map[string]string)
	for k, v := range outputMap {
		resultMap[k] = fmt.Sprintf("%v", v)
	}
	return resultMap, nil
}

// OutputForKeys calls terraform output for the given key list and returns values as a map.
// If keys not found in the output, fails the test
func OutputForKeys(t *testing.T, options *Options, keys []string) map[string]interface{} {
	out, err := OutputForKeysE(t, options, keys)
	require.NoError(t, err)
	return out
}

// OutputForKeysE calls terraform output for the given key list and returns values as a map.
// The returned values are of type interface{} and need to be type casted as necessary. Refer to output_test.go
func OutputForKeysE(t *testing.T, options *Options, keys []string) (map[string]interface{}, error) {
	out, err := RunTerraformCommandE(t, options, "output", "-no-color", "-json")
	if err != nil {
		return nil, err
	}

	outputMap := map[string]map[string]interface{}{}
	if err := json.Unmarshal([]byte(out), &outputMap); err != nil {
		return nil, err
	}

	if keys == nil {
		outputKeys := make([]string, 0, len(outputMap))
		for k := range outputMap {
			outputKeys = append(outputKeys, k)
		}
		keys = outputKeys
	}

	resultMap := make(map[string]interface{})
	for _, key := range keys {
		value, containsValue := outputMap[key]["value"]
		if !containsValue {
			return nil, OutputKeyNotFound(string(key))
		}
		resultMap[key] = value
	}
	return resultMap, nil
}

// OutputAll calls terraform output returns all values as a map.
// If there is error fetching the output, fails the test
func OutputAll(t *testing.T, options *Options) map[string]interface{} {
	out, err := OutputAllE(t, options)
	require.NoError(t, err)
	return out
}

// OutputAllE calls terraform and returns all the outputs as a map
func OutputAllE(t *testing.T, options *Options) (map[string]interface{}, error) {
	return OutputForKeysE(t, options, nil)
}
