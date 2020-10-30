# AWS S3 Account Public Access Block
This module sets an S3 public access block at the account level. That way we don't have to do this individually for all buckets.

Restrict:
- `all`: will block all types of public access for all buckets in the account.
- `new`: will block any new access to S3 buckets, but preserve any existing access.
- `none`: will not block any S3 public access.

<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| restrict | How restrictive should the account-wide access block be. Accepted values are `all`, `new`, `none`.<br>  `all` blocks public access to all buckets in account.<br>  `new` prevents you from granting public access to any more buckets, existing public buckets remain public.<br>  `none` restricts no access. | `string` | `"all"` | no |

## Outputs

| Name | Description |
|------|-------------|
| block\_settings | The computed block configuration |

<!-- END -->
