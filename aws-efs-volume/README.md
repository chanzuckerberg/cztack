<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| volume\_name |  | string | n/a | yes |
| kms\_key\_id | KMS key ID to use for encryption | kms key | n/a | no |
| env |  | string | n/a | yes |
| owner |  | string | n/a | yes |
| project |  | string | n/a | yes |
| service |  | string | n/a | yes |
| vpc\_id | VPC ID that should be able to access this volume | list | n/a | yes |
| cidr\_blocks | A list of CIDR blocks that should be allowed to communicate with this EFS volume | list | [] | no |
| security\_groups | A list of security groups that should be allowed to communicate with this EFS volume. | list | [] | no |
| subnets\_ids | Subnets that need access to this EFS volume | list | [] | no |

## Outputs

| Name | Description |
|------|-------------|
| id | EFS volume id |
| dns\_name | DNS name to reach the EFS volume |
| security\_group | ID of the security group attached to the efs volume |

<!-- END -->
