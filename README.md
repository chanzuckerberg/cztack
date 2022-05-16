# CZtack

Cztack (pronounced "stack") is CZI's collection of Terraform modules. We use these as way to scale our infrastructure work.

These modules are compatible with Terraform 0.12 and up.

## Contributing

### Making a release

Release-please managages all the releases. To make a release, merge the release PR.

### Adding a new module

To create a new module, copy the `module-template` directory and modify as you see fit. And make sure to add the module to the list of modules to test in .github/workflows/ci.yml.

### Writing tests

A few notes on writing test for this repo. Note that this is new ground for us, so this will be a work in progress.

* To make modules testable, all fields that have a unique constraint need to be parameterizeable. Otherwise concurrent tests will conflict.
* It is tempting in testing module A to use module B to set up some context, but because terraform will just store the statefile locally, you can have a conflict.
  * We've tried to avoid this for now and set up context more directly
  * And also to not run tests in parrallel
  * and to clean up state files before and after each run
* our linter requires a test for each module. At the very least run `init` so that its syntax is checked. See [an example here](aws-iam-group-assume-role/module_test.go).
* AWS IAM is eventually consistent and supposedly is homed in us-east-1, so its probably best to run all tests that use IAM in that region.

#### Test Dependencies

* [go](https://golang.org/doc/install)
* [terraform](https://www.terraform.io/intro/getting-started/install.html)
* [terraform-provider-bless](https://github.com/chanzuckerberg/terraform-provider-bless/releases) - Place it in the same directory as your terraform executable. `dirname \`which terraform\``
