# aws-cloudfront-logs-bucket

This module uses the `aws-s3-private-bucket` module as its source and enables logging for Cloudfront to the specified S3 bucket. We include the grant to `aws-logs-delivery` whose canonical id is `c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0`, documentation for this can be found [here](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html#AccessLogsBucketAndFileOwnership). The suggestion is found here:

```
Restoring the ACL for the bucket
If you remove permissions for the awslogsdelivery account, CloudFront won't be able to save logs to the S3 bucket. To enable CloudFront to start saving logs for your distribution again, restore the ACL permission by doing one of the following:

...

Add the ACL permission for awslogsdelivery manually by navigating to the S3 bucket in the Amazon S3 console and adding permission. To add the ACL for awslogsdelivery, you must provide the canonical ID for the account, which is the following:

c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0
```

## Example

```hcl
module "s3-bucket" {
  source      = "github.com/chanzuckerberg/cztack/aws-cloudfront-logs-bucket?ref=v0.33.1"
  bucket_name = "..."
  env         = var.env
  owner       = var.owner
  project     = var.project
  service     = var.component
}
```

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
| <a name="module_aws-cloudfront-logs-bucket"></a> [aws-cloudfront-logs-bucket](#module\_aws-cloudfront-logs-bucket) | ../aws-s3-private-bucket | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_canonical_user_id.current_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/canonical_user_id) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_abort_incomplete_multipart_upload_days"></a> [abort\_incomplete\_multipart\_upload\_days](#input\_abort\_incomplete\_multipart\_upload\_days) | Number of days after which an incomplete multipart upload is canceled. | `number` | `14` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | n/a | `string` | `""` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Keep old versions of overwritten S3 objects. | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of maps containing configuration of object lifecycle management. | `any` | <pre>[<br>  {<br>    "enabled": true,<br>    "expiration": {<br>      "expired_object_delete_marker": true<br>    },<br>    "noncurrent_version_expiration": {<br>      "days": 365<br>    },<br>    "noncurrent_version_transition": {<br>      "days": 30,<br>      "storage_class": "STANDARD_IA"<br>    }<br>  }<br>]</pre> | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_public_access_block"></a> [public\_access\_block](#input\_public\_access\_block) | n/a | `bool` | `true` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | HACK(el): we do this to hint TF dependency graph since modules can't depend\_on |
<!-- END -->
