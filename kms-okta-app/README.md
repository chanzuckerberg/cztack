This is a module that creates an Okta app that's bounded to a KMS Key. You can use the KMS key to sign JWTs that are compatible with the Okta /token endpoints. 

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_external"></a> [external](#provider\_external) | n/a |
| <a name="provider_okta"></a> [okta](#provider\_okta) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_app_oauth.idp_api](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_oauth) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [external_external.jwks_info](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_friendly_key_identifier"></a> [friendly\_key\_identifier](#input\_friendly\_key\_identifier) | A name for the key configuration in the okta app, something you will recognize for yourself and the project. | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The Key ID or alias of the AWS KMS Key. It has to be available in the same region and account as the configured provider. | `string` | n/a | yes |
| <a name="input_okta_configuration"></a> [okta\_configuration](#input\_okta\_configuration) | Details needed to configure an okta app. Its token auth method is private\_key\_jwt | <pre>object({<br>    label          = string<br>    type           = string<br>    grant_types    = list(string)<br>    omit_secret    = bool<br>    response_types = list(string)<br>    pkce_required  = bool<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
<!-- END -->