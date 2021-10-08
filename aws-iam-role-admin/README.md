<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_role"></a> [role](#module\_role) | ../aws-iam-role-crossacct |  |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.acm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.guardduty](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.kinesis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.route53](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.securityhub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm"></a> [acm](#input\_acm) | Whether this role should be attached to the AWSCertificateManagerFullAccess policy | `bool` | `false` | no |
| <a name="input_all"></a> [all](#input\_all) | Whether this role should be attached to the AdministratorAccess policy | `bool` | `false` | no |
| <a name="input_cloudtrail"></a> [cloudtrail](#input\_cloudtrail) | n/a | `bool` | `false` | no |
| <a name="input_cloudwatch"></a> [cloudwatch](#input\_cloudwatch) | n/a | `bool` | `false` | no |
| <a name="input_config"></a> [config](#input\_config) | n/a | `bool` | `false` | no |
| <a name="input_ecr"></a> [ecr](#input\_ecr) | n/a | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_guardduty"></a> [guardduty](#input\_guardduty) | n/a | `bool` | `false` | no |
| <a name="input_iam"></a> [iam](#input\_iam) | Permit IAMFullAccess (iam:*) for this role. | `bool` | `false` | no |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | IAM path under which to create the role. | `string` | `"/"` | no |
| <a name="input_kinesis"></a> [kinesis](#input\_kinesis) | n/a | `bool` | `false` | no |
| <a name="input_kms"></a> [kms](#input\_kms) | Whether this role should be attached to the AWSKeyManagementServicePowerUser policy | `bool` | `false` | no |
| <a name="input_lambda"></a> [lambda](#input\_lambda) | n/a | `bool` | `false` | no |
| <a name="input_oidc"></a> [oidc](#input\_oidc) | A list of AWS OIDC IDPs to establish a trust relationship for this role. | <pre>list(object(<br>    {<br>      idp_arn : string,          # the AWS IAM IDP arn<br>      client_ids : list(string), # a list of oidc client ids<br>      provider : string          # your provider url, such as foo.okta.com<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_readonly"></a> [readonly](#input\_readonly) | Permit readonly access (across all services). | `bool` | `true` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the role to create. | `string` | n/a | yes |
| <a name="input_route53"></a> [route53](#input\_route53) | Permit Route53 (route53:*) for this role. | `bool` | `false` | no |
| <a name="input_saml_idp_arns"></a> [saml\_idp\_arns](#input\_saml\_idp\_arns) | A set of IDP SAML arns allowed to assume this role. | `set(string)` | `[]` | no |
| <a name="input_secretsmanager"></a> [secretsmanager](#input\_secretsmanager) | n/a | `bool` | `false` | no |
| <a name="input_securityhub"></a> [securityhub](#input\_securityhub) | n/a | `bool` | `false` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | n/a | yes |
| <a name="input_source_account_ids"></a> [source\_account\_ids](#input\_source\_account\_ids) | A set of accounts which are allowed to assume this role. | `set(string)` | `[]` | no |
| <a name="input_ssm"></a> [ssm](#input\_ssm) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
<!-- END -->
