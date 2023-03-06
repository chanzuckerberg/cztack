## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_lambda_pull"></a> [allow\_lambda\_pull](#input\_allow\_lambda\_pull) | Whether lambda can pull this ECR | `bool` | `false` | no |
| <a name="input_ecr_resource_policy"></a> [ecr\_resource\_policy](#input\_ecr\_resource\_policy) | ECR resource-level policy, as JSON string | `string` | `null` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | Allows this ECR repo to be automated deleted with terraform destroy. False by default | `bool` | `false` | no |
| <a name="input_lifecycle_policy"></a> [lifecycle\_policy](#input\_lifecycle\_policy) | ECR ifecycle policy, as JSON string. If provided, max\_images is ignored. | `string` | `""` | no |
| <a name="input_max_image_count"></a> [max\_image\_count](#input\_max\_image\_count) | Maximum number of images to keep. ECR has a service limit of 1000 images. Ignored if lifecycle\_policy is provided. | `number` | `100` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_read_arns"></a> [read\_arns](#input\_read\_arns) | ARNs of users/roles allowed to read images from the repository. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to ECR repo | <pre>object({<br>    project : string,<br>    env : string,<br>    service : string,<br>    owner : string,<br>    managedBy : string<br>  })</pre> | n/a | yes |
| <a name="input_write_arns"></a> [write\_arns](#input\_write\_arns) | ARNs of users/roles allowed to write images to the repository. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | n/a |
| <a name="output_repository_name"></a> [repository\_name](#output\_repository\_name) | n/a |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | n/a |
