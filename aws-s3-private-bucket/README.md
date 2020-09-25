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
| aws | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| abort\_incomplete\_multipart\_upload\_days | Number of days after which an incomplete multipart upload is canceled. | `number` | `14` | no |
| bucket\_name | n/a | `string` | n/a | yes |
| bucket\_policy | n/a | `string` | `""` | no |
| cors\_rules | List of maps containing the cors rule configuration objects. | `any` | `[]` | no |
| enable\_versioning | Keep old versions of overwritten S3 objects. | `bool` | `true` | no |
| env | n/a | `string` | n/a | yes |
| grants | A list of objects containing the grant configuration, with `permissions` and either `canonical_user_id` or `uri`. Used when we want to grant permissions to AWS accounts via the S3 ACL system. | `any` | `[]` | no |
| lifecycle\_rules | List of maps containing configuration of object lifecycle management. | `any` | <pre>[<br>  {<br>    "enabled": true,<br>    "expiration": {<br>      "expired_object_delete_marker": true<br>    },<br>    "noncurrent_version_expiration": {<br>      "days": 365<br>    },<br>    "noncurrent_version_transition": {<br>      "days": 30,<br>      "storage_class": "STANDARD_IA"<br>    }<br>  }<br>]</pre> | no |
| owner | n/a | `string` | n/a | yes |
| project | n/a | `string` | n/a | yes |
| public\_access\_block | n/a | `bool` | `true` | no |
| service | n/a | `string` | n/a | yes |
| transfer\_acceleration | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| domain\_name | n/a |
| id | n/a |
| name | HACK(el): we do this to hint TF dependency graph since modules can't depend\_on |

<!-- END -->
