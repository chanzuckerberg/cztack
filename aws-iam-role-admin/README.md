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
| acm | Whether this role should be attached to the AWSCertificateManagerFullAccess policy | `bool` | `false` | no |
| all | Whether this role should be attached to the AdministratorAccess policy | `bool` | `false` | no |
| cloudtrail | n/a | `bool` | `false` | no |
| cloudwatch | n/a | `bool` | `false` | no |
| config | n/a | `bool` | `false` | no |
| ecr | n/a | `bool` | `false` | no |
| env | n/a | `string` | n/a | yes |
| guardduty | n/a | `bool` | `false` | no |
| iam | Permit IAMFullAccess (iam:\*) for this role. | `bool` | `false` | no |
| iam\_path | IAM path under which to create the role. | `string` | `"/"` | no |
| kinesis | n/a | `bool` | `false` | no |
| kms | Whether this role should be attached to the AWSKeyManagementServicePowerUser policy | `bool` | `false` | no |
| lambda | n/a | `bool` | `false` | no |
| oidc | A list of AWS OIDC IDPs to establish a trust relationship for this role. | <pre>list(object(<br>    {<br>      idp_arn : string,          # the AWS IAM IDP arn<br>      client_ids : list(string), # a list of oidc client ids<br>      provider : string          # your provider url, such as foo.okta.com<br>    }<br>  ))</pre> | `[]` | no |
| owner | n/a | `string` | n/a | yes |
| project | n/a | `string` | n/a | yes |
| readonly | Permit readonly access (across all services). | `bool` | `true` | no |
| role\_name | The name of the role to create. | `string` | n/a | yes |
| route53 | Permit Route53 (route53:\*) for this role. | `bool` | `false` | no |
| saml\_idp\_arns | A set of IDP SAML arns allowed to assume this role. | `set(string)` | `[]` | no |
| secretsmanager | n/a | `bool` | `false` | no |
| securityhub | n/a | `bool` | `false` | no |
| service | n/a | `string` | n/a | yes |
| source\_account\_ids | A set of accounts which are allowed to assume this role. | `set(string)` | `[]` | no |
| ssm | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_name | n/a |

<!-- END -->
