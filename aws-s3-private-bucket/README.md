# aws-s3-private-bucket

This module creates a bucket indented for non-public traffic. It can be made public via a bucket_policy and setting public_access_block=false.

## Example

```hcl
module "s3-bucket" {
  source      = "github.com/chanzuckerberg/cztack/aws-s3-private-bucket?ref=v0.33.1"
  bucket_name = "..."
  env         = var.env
  owner       = var.owner
  project     = var.project
  service     = var.component

  # optional, defined when using grant ACL, if not defined, the bucket will use the `acl = private` as default
  # canonical_user_id and uri in each grant should be specified exclusively
  # Specify canonical_user_id when the type is Group
  # Specify uri when the type is CanonicalUser
  grants = [
    {
      canonical_user_id : "canonical_user1_id"
      permissions : ["FULL_CONTROL"]
    },
    {
      uri : "uri_address_to_grant"
      permissions : ["WRITE"]
    }
  ]
}
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_abort_incomplete_multipart_upload_days"></a> [abort\_incomplete\_multipart\_upload\_days](#input\_abort\_incomplete\_multipart\_upload\_days) | Number of days after which an incomplete multipart upload is canceled. The value for this variable is set for all lifecycle rules, to specify the abort\_incomplete\_multipart\_upload\_days for each rule, you can specify it in the lifecycle\_rules variable. | `number` | `14` | no |
| <a name="input_acl"></a> [acl](#input\_acl) | Canned ACL to use if grants object is not given. See https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html#canned-acl | `string` | `"private"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | n/a | `string` | `""` | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | List of maps containing the cors rule configuration objects. | `any` | `[]` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Keep old versions of overwritten S3 objects. | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_grants"></a> [grants](#input\_grants) | A list of objects containing the grant configurations. Used when we want to grant permissions to AWS accounts via the S3 ACL system. | `any` | `[]` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of maps containing configuration of object lifecycle management. | `any` | <pre>[<br>  {<br>    "abort_incomplete_multipart_upload_days": 7,<br>    "enabled": true,<br>    "expiration": {<br>      "expired_object_delete_marker": true<br>    },<br>    "noncurrent_version_expiration": {<br>      "days": 365<br>    },<br>    "noncurrent_version_transition": {<br>      "days": 30,<br>      "storage_class": "STANDARD_IA"<br>    }<br>  }<br>]</pre> | no |
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | Log bucket name and prefix to enable logs for this bucket | `object({ name = string, prefix = string })` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_public_access_block"></a> [public\_access\_block](#input\_public\_access\_block) | n/a | `bool` | `true` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | n/a | yes |
| <a name="input_transfer_acceleration"></a> [transfer\_acceleration](#input\_transfer\_acceleration) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | HACK(el): we do this to hint TF dependency graph since modules can't depend\_on |
<!-- END -->
