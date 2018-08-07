# secrets setup

This module does the work of preparing an AWS account to use [Chamber](https://github.com/segmentio/chamber) for managing secrets.

Currently that just means creating an KMS key for encrypting the parameters store entries.


<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alias_name | Chamber is hard coded to use a KMS alias with the name 'parameter_store_key'. | string | `parameter_store_key` | no |

<!-- END -->
