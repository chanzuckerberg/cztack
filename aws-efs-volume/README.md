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
| cidr\_blocks | A list of CIDR blocks that should be allowed to communicate with this EFS volume | `list(string)` | `[]` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| kms\_key\_id | If supplied, EFS will use this key to encrypt data at rest. Empty string means that EFS will use an AWS-managed key. Encryption is always on with this module. | `string` | `""` | no |
| owner | n/a | `string` | n/a | yes |
| project | n/a | `string` | n/a | yes |
| security\_groups | A list of security groups that should be allowed to communicate with this EFS volume. | `list(string)` | `[]` | no |
| service | n/a | `string` | n/a | yes |
| subnet\_ids | A list of subnets that need EFS targets created for this resource | `list(string)` | `[]` | no |
| volume\_name | Name of the volume | `string` | n/a | yes |
| vpc\_id | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dns\_name | n/a |
| id | HACK(el): we do this to hint TF dependency graph since modules can't depend\_on |
| security\_group | n/a |

<!-- END -->
