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
  source = "github.com/chanzuckerberg/cztack//bless-ca?ref=master"

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
  source = "github.com/chanzuckerberg/cztack//aws-iam-role-bless?ref=master"

  role_name         = "blessclient"
  source_account_id = "..."

  bless_lambda_arns = [
    "${module.bless.lambda_arn}",
  ]
}

# Group that authorizes users to invoke bless lambda
module "bless-users" {
  // Replace with latest cztack stable release https://github.com/chanzuckerberg/cztack/releases
  source = "github.com/chanzuckerberg/cztack//aws-iam-group-assume-role?ref=master"

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
| aws | n/a |
| bless | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| authorized\_users | A list of IAM users authorized ot invoke bless and the corresponding kmsauth key. | `list` | `[]` | no |
| bless\_logging\_level | Bless lambda logging level. | `string` | `"INFO"` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| iam\_path | The IAM path under which the Bless lambda will be run. | `string` | `"/"` | no |
| kmsauth\_iam\_group\_name\_format | Formatting string to tell bless which IAM groups are relevant when checking SSH certificate principal validity. | `string` | `"{}"` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ca\_public\_key | n/a |
| lambda\_arn | n/a |

<!-- END -->
