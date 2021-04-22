# AWs IAM Role for ECS Tasks

This will create a role for attaching to an ECS task, using `policy`.

## Example

```hcl
module "ecs-role" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-ecs-task-role?ref=v0.14.0"

  # Variables used for tagging.
  project = "..."
  env     = "..."
  service = "..."
  owner   = "..."
}

output "ecs-role-arn" {
  value = "${module.ecs-role.arn}"
}
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | < 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment name. For example– dev, staging or prod. | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | IAM path for the role. | `string` | `"/"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Email address of the owner. Can be a group address. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | High-level project, should be unique across the organization. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Name of this thing we're running. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END -->
