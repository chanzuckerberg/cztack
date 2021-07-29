# Bless CA

This module does the heavy-lifting of setting up a [BLESS](https://github.com/Netflix/bless) lambda function. Bless is an SSH certificate authority– you can use it to authorize users to SSH into individual machines without managing authorized keys for each user.

A few things this module does for you–

* Creates the CA keypair
  * Encrypts it with KMS
  * A [custom provider](https://github.com/chanzuckerberg/terraform-provider-bless) ensures no sensitive material is persisted to the terraform state
* Creates a [kmsauth](https://github.com/lyft/python-kmsauth) kms key
  * And authorizes a list of IAM users to allow them to assert their identity through kmsauth
* Packages and configures the Bless Lambda using a [custom provider](https://github.com/chanzuckerberg/terraform-provider-bless)
  * Creates the bless lambda execution role
  * Configures the bless lambda with some defaults (which you can override)

## Usage
- In order to protect the CA private key, it is recommended running this module in an isolated and restricted AWS account.
- To use this terraform module, you will have to [configure](https://www.terraform.io/docs/plugins/basics.html#installing-a-plugin) the [terraform-provider-bless](https://github.com/chanzuckerberg/terraform-provider-bless).
If you are using [fogg](https://github.com/chanzuckerberg/fogg) this can also be done by adding the following to your `fogg.json` and then running `fogg apply`:
```json
{
  "defaults":{},
  "modules":{},
  "accounts":{},
  "envs":{},
  "plugins": {
    "terraform_providers": {
      "terraform-provider-bless": {
        "url": "https://github.com/chanzuckerberg/terraform-provider-bless/releases/download/v0.2.5/terraform-provider-bless_0.2.5_linux_amd64.tar.gz",
        "format": "tar"
      }
    }
  }
}
```

- To interact with Bless you can use [blessclient](https://github.com/chanzuckerberg/blessclient).
- To achieve multi-region availability, you can configure different terraform providers (aws and bless) in different regions.


## Example

```hcl
// Configure the terraform-provider-bless
provider "bless" {
  region  = "${var.region}"
  profile = "<aws_profile>"
}

module "bless" {
  // Replace with latest cztack stable release https://github.com/chanzuckerberg/cztack/releases
  source = "github.com/chanzuckerberg/cztack//bless-ca?ref=v0.36.0"

  project = "..."
  service = "..."
  env     = "..."
  owner   = "..."

  region           = "..."
  authorized_users = ["..."]
  aws_account_id   = "..."
}

module "blessclient" {
  // Replace with latest cztack stable release https://github.com/chanzuckerberg/cztack/releases
  source = "github.com/chanzuckerberg/cztack//aws-iam-role-bless?ref=v0.36.0"

  role_name         = "blessclient"
  source_account_id = "..."

  bless_lambda_arns = [
    "${module.bless.lambda_arn}",
  ]
}

# Group that authorizes users to invoke bless lambda
module "bless-users" {
  // Replace with latest cztack stable release https://github.com/chanzuckerberg/cztack/releases
  source = "github.com/chanzuckerberg/cztack//aws-iam-group-assume-role?ref=v0.36.0"

  users           = ["..."]
  group_name      = "bless-users"
  target_accounts = ["..."]
  target_role     = "${module.blessclient.role_name}"
}
```

## Resources

You can read more about Bless and SSH certificates here:
* https://github.com/Netflix/bless
* https://eng.lyft.com/blessing-your-ssh-at-lyft-a1b38f81629d
* https://code.fb.com/security/scalable-and-secure-access-with-ssh/


<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_bless"></a> [bless](#provider\_bless) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ../aws-lambda-function |  |
| <a name="module_logs_policy"></a> [logs\_policy](#module\_logs\_policy) | ../aws-iam-policy-cwlogs |  |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.bless](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kms_alias.bless](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.bless_kms_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.bless](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.bless_kms_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [bless_ca.bless](https://registry.terraform.io/providers/hashicorp/bless/latest/docs/resources/ca) | resource |
| [random_id.path](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kmsauth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [bless_lambda.code](https://registry.terraform.io/providers/hashicorp/bless/latest/docs/data-sources/lambda) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorized_users"></a> [authorized\_users](#input\_authorized\_users) | A list of IAM users authorized ot invoke bless and the corresponding kmsauth key. | `list(any)` | `[]` | no |
| <a name="input_bless_logging_level"></a> [bless\_logging\_level](#input\_bless\_logging\_level) | Bless lambda logging level. | `string` | `"INFO"` | no |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | The IAM path under which the Bless lambda will be run. | `string` | `"/"` | no |
| <a name="input_kmsauth_iam_group_name_format"></a> [kmsauth\_iam\_group\_name\_format](#input\_kmsauth\_iam\_group\_name\_format) | Formatting string to tell bless which IAM groups are relevant when checking SSH certificate principal validity. | `string` | `"{}"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_public_key"></a> [ca\_public\_key](#output\_ca\_public\_key) | n/a |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | n/a |
<!-- END -->
