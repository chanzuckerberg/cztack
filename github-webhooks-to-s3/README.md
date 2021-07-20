# GitHub Webhooks to S3

This module will configure an aggregator for GitHub webhooks. It sets up an API Gateway with a Lambda that will authenticate incomming webhooks from GitHub and then use Firehose to store these events into S3. This module will configure the necessary IAM Roles, S3 bucket, API Gateway, and Firehose resources.

## Usage
- Create a Webhook you would like to capture in GitHub and point it at your `var.fqdn`.
- API Gateway relies on ACM Certificates in us-east-1
- This module reads secrets from the AWS ParamStore using [chamber](https://github.com/segmentio/chamber).You can write the GitHub validation secret `AWS_PROFILE=<your profile> chamber write <var.project>-<var.env>-<var.service> github_secret <the secret>`

```hcl
module "archiver" {
  // Replace with latest cztack stable release https://github.com/chanzuckerberg/cztack/releases
  source = "github.com/chanzuckerberg/cztack//github-webhooks-to-s3?ref=v0.40.0"

  env     = "${var.env}"
  project = "${var.project}"
  owner   = "${var.owner}"
  service = "${var.component}"

  fqdn            = "github.foo.bar.com"
  certificate_arn = "..." // This MUST be in us-east-1 region
  route53_zone_id = "..." // Route53 zone to write records to
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
| <a name="module_attach-logs"></a> [attach-logs](#module\_attach-logs) | ../aws-iam-policy-cwlogs | n/a |
| <a name="module_bucket"></a> [bucket](#module\_bucket) | ../aws-s3-private-bucket | n/a |
| <a name="module_github_secret"></a> [github\_secret](#module\_github\_secret) | ../aws-ssm-params | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_base_path_mapping.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_base_path_mapping) | resource |
| [aws_api_gateway_deployment.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_domain_name.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_domain_name) | resource |
| [aws_api_gateway_integration.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration.lambda_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_method.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method.github_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_resource.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource) | resource |
| [aws_api_gateway_rest_api.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_cloudwatch_log_group.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_iam_role.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.firehose-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kinesis_firehose_delivery_stream.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.apigw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_route53_record.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.github-ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.firehose-to-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.firehose-write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | A certificate in us-east-1 for var.fqdn | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. | `string` | n/a | yes |
| <a name="input_fqdn"></a> [fqdn](#input\_fqdn) | The fqdn to expose the api gateway as | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | n/a | `string` | `"/"` | no |
| <a name="input_lambda_source_s3_bucket"></a> [lambda\_source\_s3\_bucket](#input\_lambda\_source\_s3\_bucket) | The s3 bucket where to find the lambda executable | `string` | `"shared-infra-prod-assets"` | no |
| <a name="input_lambda_source_s3_key"></a> [lambda\_source\_s3\_key](#input\_lambda\_source\_s3\_key) | The s3 key where to find the lambda executable | `string` | `"go-misc/lambdas/2019/06/03/github_to_firehose.zip"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | The route53 zone id for fqdn's domain | `string` | n/a | yes |
| <a name="input_s3_prefix"></a> [s3\_prefix](#input\_s3\_prefix) | Firehose will add this prefix to files it writes to the s3 bucket | `string` | `""` | no |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | S3 bucket that Github webhooks are streamed into |
<!-- END -->
