# aws-s3-cdn

Private S3 bucket with optional CloudFront (OAC) delivery, geofencing, CORS, and in-cluster access
(IRSA/boto or Mountpoint-S3 CSI). The bucket is always private and deny-all by default; public access
is only ever served through CloudFront, so it always stays geofenced.

Combine the options per bucket:

- `delivery = "cloudfront"` — adds an Origin Access Control, a CloudFront-only bucket policy, the
  distribution, a CORS response-headers policy, and a geofence (default: the org-wide sanctioned-country
  blacklist). `delivery = "none"` leaves the bucket private with no public serving.
- `boto` — an IRSA role trusting one or more EKS ServiceAccounts for in-cluster SDK access.
- `csi` — attaches an S3 access policy to the shared Mountpoint-S3 CSI driver role(s) so the bucket can
  be mounted into pods.

`delivery` and the cluster-access options are independent and can be combined on the same bucket.

## Usage

Public dataset served through CloudFront (private origin, geofenced):

```hcl
module "intracktive_zarrs" {
  source      = "github.com/chanzuckerberg/cztack//aws-s3-cdn?ref=vX.Y.Z"
  bucket_name = "intracktive-zarrs-prod"
  delivery    = "cloudfront"
  region      = var.region

  project = var.tags.project
  env     = var.tags.env
  service = var.tags.service
  owner   = var.tags.owner
}
```

In-cluster app reading via the AWS SDK (IRSA / boto3):

```hcl
module "gene2fish" {
  source      = "github.com/chanzuckerberg/cztack//aws-s3-cdn?ref=vX.Y.Z"
  bucket_name = "gene2fish-zfin-images-dev"

  boto = {
    role_name = "gene2fish-dev"
    prefix    = "gene2fish/zfin-images" # scope reads to the mirror prefix
    trusts = [{
      oidc_provider_arn = data.aws_iam_openid_connect_provider.dev_biohub.arn
      oidc_issuer_url   = data.aws_eks_cluster.dev_biohub.identity[0].oidc[0].issuer
      namespace         = "argus-gene2fish-rdev"
      service_account   = "gene2fish"
      match_type        = "StringLike"
    }]
  }

  project = var.tags.project
  env     = var.tags.env
  service = var.tags.service
  owner   = var.tags.owner
}
```

Viz/dashboard app mounting the bucket as files (CSI / Mountpoint-S3, high-speed reads):

```hcl
module "diffex_viewer" {
  source      = "github.com/chanzuckerberg/cztack//aws-s3-cdn?ref=vX.Y.Z"
  bucket_name = "diffex-viewer-dev"

  csi = {
    role_names = [
      data.aws_iam_role.s3_csi_role_arn.name,
      data.aws_iam_role.s3_csi_role_staging.name,
    ]
  }

  project = var.tags.project
  env     = var.tags.env
  service = var.tags.service
  owner   = var.tags.owner
}
```

`delivery` and the cluster-access options combine on one bucket (e.g. GRASSP prod uses
`delivery = "cloudfront"` + `boto`). When migrating an existing distribution, also pass
`origin_id = "<legacy-origin-id>"` to avoid replacing it.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.56.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_bucket"></a> [bucket](#module\_bucket) | ../aws-s3-private-bucket | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_cloudfront_response_headers_policy.cors](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_response_headers_policy) | resource |
| [aws_iam_policy.csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.boto](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.boto](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.boto](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.boto_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.oac](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allowed_methods"></a> [allowed\_methods](#input\_allowed\_methods) | n/a | `list(string)` | <pre>[<br/>  "GET",<br/>  "HEAD",<br/>  "OPTIONS"<br/>]</pre> | no |
| <a name="input_boto"></a> [boto](#input\_boto) | Creates an IRSA role for in-cluster SDK (boto) access. 'trusts' may list multiple clusters; use match\_type 'StringLike' for wildcard namespaces. 'prefix' scopes access to a key prefix. | <pre>object({<br/>    role_name   = string<br/>    policy_name = optional(string)<br/>    read_write  = optional(bool, false)<br/>    prefix      = optional(string)<br/>    trusts = list(object({<br/>      oidc_provider_arn = string<br/>      oidc_issuer_url   = string<br/>      namespace         = string<br/>      service_account   = string<br/>      match_type        = optional(string, "StringEquals")<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the S3 bucket. Single source of truth for every ARN the module builds. Keep stable — external upload roles (shared-infra) hardcode it. | `string` | n/a | yes |
| <a name="input_cache_default_ttl"></a> [cache\_default\_ttl](#input\_cache\_default\_ttl) | Default cache TTL. Pass 0 for non-prod / always-revalidate buckets. | `number` | `31536000` | no |
| <a name="input_cache_max_ttl"></a> [cache\_max\_ttl](#input\_cache\_max\_ttl) | n/a | `number` | `31536000` | no |
| <a name="input_cache_min_ttl"></a> [cache\_min\_ttl](#input\_cache\_min\_ttl) | n/a | `number` | `0` | no |
| <a name="input_cache_policy_id"></a> [cache\_policy\_id](#input\_cache\_policy\_id) | Opt-in managed cache policy id. When set, the legacy forwarded\_values block and min/default/max\_ttl are omitted. | `string` | `null` | no |
| <a name="input_cached_methods"></a> [cached\_methods](#input\_cached\_methods) | n/a | `list(string)` | <pre>[<br/>  "GET",<br/>  "HEAD",<br/>  "OPTIONS"<br/>]</pre> | no |
| <a name="input_cloudfront_cors"></a> [cloudfront\_cors](#input\_cloudfront\_cors) | CloudFront CORS response-headers policy config. Only used when delivery='cloudfront'. | <pre>object({<br/>    enabled           = optional(bool, true)<br/>    allow_origins     = optional(list(string), ["*"])<br/>    allow_methods     = optional(list(string), ["GET", "HEAD", "OPTIONS"])<br/>    allow_headers     = optional(list(string), ["Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"])<br/>    expose_headers    = optional(list(string), ["Content-Length", "Content-Type"])<br/>    allow_credentials = optional(bool, false)<br/>    max_age_sec       = optional(number, 31536000)<br/>    origin_override   = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_compress"></a> [compress](#input\_compress) | n/a | `bool` | `true` | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | S3-level CORS rules (rarely needed; CloudFront CORS is configured via var.cloudfront\_cors). | `any` | `[]` | no |
| <a name="input_csi"></a> [csi](#input\_csi) | Attaches an S3 access policy to the shared Mountpoint-S3 CSI driver role(s) so the bucket can be mounted into pods. role\_names are the existing CSI driver role names. | <pre>object({<br/>    policy_name = optional(string)<br/>    read_write  = optional(bool, false)<br/>    prefix      = optional(string)<br/>    role_names  = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_delivery"></a> [delivery](#input\_delivery) | How the bucket is served publicly. 'none' = private only. 'cloudfront' = OAC + distribution + geofence (+ CORS). Public access is only ever via CloudFront (so it stays geofenced). | `string` | `"none"` | no |
| <a name="input_distribution_comment"></a> [distribution\_comment](#input\_distribution\_comment) | CloudFront distribution comment. Defaults to '<bucket\_name> (S3, OAC)'. | `string` | `null` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Keep old versions of overwritten objects. | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_extra_bucket_policy_json"></a> [extra\_bucket\_policy\_json](#input\_extra\_bucket\_policy\_json) | Extra bucket policy JSON merged into the bucket policy (e.g. a log-delivery grant). Merged alongside the OAC read grant when delivery='cloudfront'; becomes the bucket policy when delivery='none'. | `string` | `""` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | n/a | `bool` | `false` | no |
| <a name="input_geo_restriction_locations"></a> [geo\_restriction\_locations](#input\_geo\_restriction\_locations) | Country codes for the CloudFront geofence. Default is the org-wide export-sanctioned list. | `list(string)` | <pre>[<br/>  "CU",<br/>  "IR",<br/>  "KP",<br/>  "SY",<br/>  "UA"<br/>]</pre> | no |
| <a name="input_geo_restriction_type"></a> [geo\_restriction\_type](#input\_geo\_restriction\_type) | CloudFront geo-restriction mode: 'blacklist', 'whitelist', or 'none'. | `string` | `"blacklist"` | no |
| <a name="input_kms_encryption"></a> [kms\_encryption](#input\_kms\_encryption) | Encrypt with a new customer-managed KMS key instead of SSE-S3. Null = SSE-S3. | `bool` | `null` | no |
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | S3 server-access-log destination bucket name + prefix. | `object({ name = string, prefix = string })` | `null` | no |
| <a name="input_oac_name"></a> [oac\_name](#input\_oac\_name) | Origin Access Control name. Defaults to '<bucket\_name>-oac'. | `string` | `null` | no |
| <a name="input_origin_id"></a> [origin\_id](#input\_origin\_id) | CloudFront origin id. Defaults to '<bucket\_name>-s3'. Override to match a legacy id and avoid distribution replacement on migration. | `string` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | n/a | yes |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | n/a | `string` | `"PriceClass_100"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region for the S3 origin domain string. Defaults to the provider's region. | `string` | `null` | no |
| <a name="input_response_headers_policy_name"></a> [response\_headers\_policy\_name](#input\_response\_headers\_policy\_name) | CORS response-headers policy name. Defaults to '<bucket\_name>-cors-policy'. | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | n/a | yes |
| <a name="input_viewer_protocol_policy"></a> [viewer\_protocol\_policy](#input\_viewer\_protocol\_policy) | n/a | `string` | `"redirect-to-https"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_boto_role_arn"></a> [boto\_role\_arn](#output\_boto\_role\_arn) | n/a |
| <a name="output_boto_role_name"></a> [boto\_role\_name](#output\_boto\_role\_name) | n/a |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | n/a |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | n/a |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | n/a |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | HACK: hint the TF dependency graph since modules can't depend\_on. Also the exact name external upload roles (shared-infra) must reference. |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | n/a |
| <a name="output_cloudfront_distribution_arn"></a> [cloudfront\_distribution\_arn](#output\_cloudfront\_distribution\_arn) | n/a |
| <a name="output_cloudfront_distribution_id"></a> [cloudfront\_distribution\_id](#output\_cloudfront\_distribution\_id) | n/a |
| <a name="output_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#output\_cloudfront\_domain\_name) | n/a |
| <a name="output_cloudfront_hosted_zone_id"></a> [cloudfront\_hosted\_zone\_id](#output\_cloudfront\_hosted\_zone\_id) | n/a |
| <a name="output_csi_policy_arn"></a> [csi\_policy\_arn](#output\_csi\_policy\_arn) | n/a |
<!-- END_TF_DOCS -->
