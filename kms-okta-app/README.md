This is a module that creates an Okta app that's bounded to an asymmetric KMS Key. You can use the KMS key to sign JWTs that are compatible with the Okta /token endpoints. 

After you create the Okta App, you can work with the Okta Token endpoint by roughly following these steps:
1. Creating a header with this kind of structure: `{{"alg": "<algorithm>", "typ": "JWT"}}`. To identify algorithms. Here are the algorithm options as of Febuary 5, 2025:
```
signing_algs = (
    ('RSASSA_PSS_SHA_256',        'PS256', 'sha256'),
    ('RSASSA_PSS_SHA_384',        'PS384', 'sha384'),
    ('RSASSA_PSS_SHA_512',        'PS512', 'sha512'),
    ('RSASSA_PKCS1_V1_5_SHA_256', 'RS256', 'sha256'),
    ('RSASSA_PKCS1_V1_5_SHA_384', 'RS384', 'sha384'),
    ('RSASSA_PKCS1_V1_5_SHA_512', 'RS512', 'sha512'),
    ('ECDSA_SHA_256',             'ES256', 'sha256'),
    ('ECDSA_SHA_384',             'ES384', 'sha384'),
    ('ECDSA_SHA_512',             'ES512', 'sha512'),
    )
```
source: https://github.com/jmtapio/python-jwt-kms/blob/552668588c5eec5eff9346740660239baef22428/jwt_kms/jwa.py 
So if your KMS key has type `RSASSA_PKCS1_V1_5_SHA_256`, your `alg` is `RS256`. If you want to dive deeper, you can look at the RFC section here: https://datatracker.ietf.org/doc/html/rfc7518#section-3.1

2. Creating a payload with this kind of structure with this format:
```json
{
    "exp": <future timestamp>,
    "iat": <number of seconds since Jan 1, 1970 UTC>,
    "iss": client_id,
    "aud": [okta_token_endpoint],
    "sub": client_id,
}
```
each attribute can be found here: https://developer.okta.com/docs/api/openapi/okta-oauth/guides/client-auth/#token-claims-for-client-authentication-with-client-secret-or-private-key-jwt

3. Base64-encode values from step #1 and #2 and strip out the equal signs (`=`). 
4. Concatenate the values from step #3 with a header.payload format, then use the AWS KMS `sign` operation from whatever AWS SDK you use. If you used algorithm type `RS256`, then your KMS Sign operation should use SigningAlgorithm type `RSASSA_PKCS1_V1_5_SHA_256`. You should be able to parse out the "Signature" value from your kms `sign` output. 
5. Construct the JWT in this way: base64header.base64payload.signature-from-step-4

After you construct the JWT, you're ready to use it with the Okta Token endpoint here: https://developer.okta.com/docs/api/openapi/okta-oauth/guides/client-auth/#jwt-with-private-key
you just need to set the JWT from step 5 to the "client_assertion" value while making the request.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_params"></a> [params](#module\_params) | github.com/chanzuckerberg/cztack//aws-ssm-params-writer | v0.63.3 |

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
| <a name="input_assume_role_name"></a> [assume\_role\_name](#input\_assume\_role\_name) | Name of the role that your Terraform environment can assume. | `string` | n/a | yes |
| <a name="input_friendly_key_identifier"></a> [friendly\_key\_identifier](#input\_friendly\_key\_identifier) | A name for the key configuration in the okta app, something you will recognize for yourself and the project. | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The Key ID or alias of the AWS KMS Key. It has to be available in the same region and account as the configured provider. | `string` | n/a | yes |
| <a name="input_okta_configuration"></a> [okta\_configuration](#input\_okta\_configuration) | Details needed to configure an okta app. Its token auth method is private\_key\_jwt | <pre>object({<br>    label          = string<br>    type           = string<br>    grant_types    = list(string)<br>    omit_secret    = bool<br>    response_types = list(string)<br>    pkce_required  = bool<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | These values are used to derive the path in the param store where to write the Okta App Configuration metadata. | <pre>object({<br>    project = string,<br>    env     = string,<br>    service = string,<br>    owner   = string,<br>  })</pre> | n/a | yes |
| <a name="input_write_metadata_to_params"></a> [write\_metadata\_to\_params](#input\_write\_metadata\_to\_params) | Whether you want to include the clientID and KMS Key Alias grouped together as securestring parameters in JSON format. If true, module will write these details to a path based on the env, project and service"<br>  They will be written following path:<br>    /<project>-<env>-<service>/client\_id<br>    /<project>-<env>-<service>/kms\_key\_id<br><br>  (the module may add secrets over time)<br><br>  Note that these values should correspond with the consuming service's tagset so secrets are placed in the path they expect. | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
| <a name="output_kms_id"></a> [kms\_id](#output\_kms\_id) | n/a |
<!-- END -->