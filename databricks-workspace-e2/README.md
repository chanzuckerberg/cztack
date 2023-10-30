## Databricks Multi-workspace
1. In `terraform/accounts/databricks-network/databricks.tf`, add a section in `networks` to specify the base CIDR block for the new workspace. Then, to specify the subnets, add a section similar to `meta_workspace_subnets`.
2. In `terraform/accounts/databricks-network/outputs.tf`, add the output for the cidr blocks you just created.
3. To setup this new workspace in TFE, here are the [docs](https://czi.atlassian.net/wiki/spaces/SI/pages/1786741987/Terraform+Enterprise#TerraformEnterprise-Migratinganewworkspaceinapre-configuredrepotoTFE) to do so.
4. After you configure TFE, in `fogg.yml`, for the env you're working in, add a `databricks-workspace` component. It will look like this:
```yaml
  databricks-workspace:
    backend:
      host_name: si.prod.tfe.czi.technology
      kind: remote
      organization: shared-infra
    extra_vars:
      databricks_external_id: value-for-external-id
```
To get the `databricks_external_id`, ask the Databricks point of contact (Taha Syed has been our POC for TLP and Meta: taha@databricks.com). It is [this value](https://databrickslabs.github.io/terraform-provider-databricks/resources/mws_workspaces/).

5. Run `fogg apply` at the root.
6. In the newly created component, create a file called `cloud-env.tf` and copy what you see in `terraform/envs/meta-prod/databricks-workspace/cloud-env.tf`. Replace the values for `database_subnet_cidrs`, `private_subnet_cidrs`, `public_subnet_cidrs`, and `vpc_cidr` with the output that you created in `outputs.tf`.
7. At minimum, you'll need something like this in `main.tf`
```terraform
  module databricks-workspace {
    source                 = "../../../modules/databricks-workspace-e2"
    databricks_external_id = var.databricks_external_id
    vpc_id                 = module.aws-env.vpc_id
    private_subnets        = module.aws-env.private_subnets
    project                = var.project
    env                    = var.env
    service                = var.component
    owner                  = var.owner
  }
```
where the `databricks_external_id` is value you specified in the `databricks-workspace` component in `fogg.yml`.

8. Add a new file called `provider.tf`. To authenticate to Databricks, we use `basic_auth` with environment variables `DATABRICKS_USERNAME` and `DATABRICKS_PASSWORD`. We store these as environment variables in the TFE workspace you're working in. They have to be named exactly those words to have the `basic_auth` pick them up. This is the default provider for Databricks:
```terraform
  provider "databricks" {
    version = "v0.2.3"
    host    = "https://accounts.cloud.databricks.com"
    basic_auth {}
  }
```
You'll also need this, if you want to authenticate per workspace:
```terraform
  provider "databricks" {
    alias   = "within_workspace"
    version = "v0.2.3"
    host    = module.databricks-workspace.workspace_url
    basic_auth {}
  }
```
To get the URL of the deployment, it'll be the `deployment_name` which is `name = "${var.project}-${var.env}-${var.component}"` which is the local in the `databricks-workspace` module appended by `.cloud.databricks.com`.

## References
* [Here](https://databrickslabs.github.io/terraform-provider-databricks/overview/) is the provider docs.

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_databricks_bucket"></a> [databricks\_bucket](#module\_databricks\_bucket) | github.com/chanzuckerberg/cztack//aws-s3-private-bucket | v0.60.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.databricks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_security_group.databricks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [databricks_mws_credentials.databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_credentials) | resource |
| [databricks_mws_networks.networking](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_networks) | resource |
| [databricks_mws_storage_configurations.databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_storage_configurations) | resource |
| [databricks_mws_workspaces.databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_workspaces) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.databricks-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.databricks-setup-assume-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audit_log_bucket_name"></a> [audit\_log\_bucket\_name](#input\_audit\_log\_bucket\_name) | Name of bucket to write cluster logs to - also where the audit logs go, too | `string` | `"czi-audit-logs"` | no |
| <a name="input_databricks_external_id"></a> [databricks\_external\_id](#input\_databricks\_external\_id) | The ID of a Databricks root account. | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | The environment / stage. Aka staging, dev, prod. | `string` | n/a | yes |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | Set default owner of all objects within bucket (e.g., bucket vs. object owner) | `string` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | n/a | yes |
| <a name="input_passable_role_arn"></a> [passable\_role\_arn](#input\_passable\_role\_arn) | A role to allow the cross-account role to pass to other accounts | `string` | `""` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnets. | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | A high level name, typically the name of the site. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | The service. Aka databricks-workspace. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC. | `string` | n/a | yes |
| <a name="input_workspace_name_override"></a> [workspace\_name\_override](#input\_workspace\_name\_override) | Override the workspace name. If not set, the workspace name will be set to the project, env, and service. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the AWS IAM role. |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | ID of the workspace. |
| <a name="output_workspace_url"></a> [workspace\_url](#output\_workspace\_url) | Url of the deployed workspace. |
<!-- END -->
