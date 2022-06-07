package main

import (
	"io/ioutil"
	"os"
	"path"
	"sort"

	"github.com/chanzuckerberg/go-misc/sets"
	"gopkg.in/yaml.v3"
)

func ensureCI(names []string) error {
	ci := map[string]interface{}{}

	cwd, err := os.Getwd()
	if err != nil {
		return err
	}

	ciPath := path.Join(cwd, "..", "..", ".github", "workflows", "ci.yml")
	ciFile, err := ioutil.ReadFile(ciPath)
	if err != nil {
		return err
	}

	err = yaml.Unmarshal(ciFile, &ci)
	if err != nil {
		return err
	}

	jobs := ci["jobs"].(map[string]interface{})
	test := jobs["test"].(map[string]interface{})
	strategy := test["strategy"].(map[string]interface{})
	matrix := strategy["matrix"].(map[string]interface{})

	modules := sets.NewStringSet().Add(names...)
	if _, ok := matrix["module"].([]interface{}); ok {
		for _, module := range matrix["module"].([]interface{}) {
			modules.Add(module.(string))
		}
	} else {
		modules.Add(matrix["module"].(string))
	}
	module := modules.List()
	sort.Strings(module)

	// ugh.. really????
	matrix["module"] = module
	strategy["matrix"] = matrix
	test["strategy"] = strategy
	jobs["test"] = test
	ci["jobs"] = jobs

	out, err := yaml.Marshal(&ci)
	if err != nil {
		return err
	}

	return ioutil.WriteFile(ciPath, out, 0644)
}
