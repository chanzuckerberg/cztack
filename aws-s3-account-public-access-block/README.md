# AWS S3 Account Public Access Block
This module sets an S3 public access block at the account level. That way we don't have to do this individually for all buckets.

Restrict:
- `all`: will block all types of public access for all buckets in the account.
- `new`: will block any new access to S3 buckets, but preserve any existing access.
- `none`: will not block any S3 public access.

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | > 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.17.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_account_public_access_block.block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_account_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_restrict"></a> [restrict](#input\_restrict) | How restrictive should the account-wide access block be. Accepted values are `all`, `new`, `none`.<br>  `all` blocks public access to all buckets in account.<br>  `new` prevents you from granting public access to any more buckets, existing public buckets remain public.<br>  `none` restricts no access. | `string` | `"all"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_block_settings"></a> [block\_settings](#output\_block\_settings) | The computed block configuration |
<!-- END -->
