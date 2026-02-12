# aws-env

This Terraform module provisions a complete AWS VPC environment with production-ready networking infrastructure.

## Features

- **VPC with Multi-Tier Subnets**: Creates public, private, and database subnets across multiple availability zones using the `terraform-aws-modules/vpc/aws` module
- **NAT Gateways**: Configures NAT gateways for private subnet internet access (supports single or per-AZ NAT gateway deployment)
- **VPC Flow Logs**: Enables flow logs to both CloudWatch Logs and S3 for network traffic monitoring and compliance
- **VPC Endpoints**: Supports AWS PrivateLink interface endpoints for secure access to AWS services without traversing the public internet
- **Kubernetes/EKS Support**: Automatically tags subnets and VPC for EKS cluster integration, including Karpenter discovery tags for node autoscaling
- **Validation**: Enforces that the number of subnets matches the number of availability zones

## Usage

```hcl
module "aws_env" {
  source = "path/to/aws-env"

  project = "my-project"
  env     = "prod"
  service = "platform"
  owner   = "infrastructure-team"
  region  = "us-west-2"

  vpc_cidr             = "10.0.0.0/16"
  azs                  = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  database_subnet_cidrs = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]

  k8s_cluster_names = ["my-eks-cluster"]
}
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_assert"></a> [assert](#provider\_assert) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_flow_log.s3_vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_security_group.vpc_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_endpoint.vpc_endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [assert_test.azs_length_check_0](https://registry.terraform.io/providers/bwoznicki/assert/latest/docs/data-sources/test) | data source |
| [assert_test.azs_length_check_1](https://registry.terraform.io/providers/bwoznicki/assert/latest/docs/data-sources/test) | data source |
| [assert_test.azs_length_check_2](https://registry.terraform.io/providers/bwoznicki/assert/latest/docs/data-sources/test) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | EC2 availability zones for the VPC. | `list(string)` | n/a | yes |
| <a name="input_create_database_subnet_route_table"></a> [create\_database\_subnet\_route\_table](#input\_create\_database\_subnet\_route\_table) | Controls if separate route table for database should be created. | `bool` | `false` | no |
| <a name="input_database_subnet_cidrs"></a> [database\_subnet\_cidrs](#input\_database\_subnet\_cidrs) | List of IP ranges for the database subnets. Must be same length as var.azs. | `list(string)` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | The environment / stage. Aka staging, dev, prod. | `string` | n/a | yes |
| <a name="input_k8s_cluster_names"></a> [k8s\_cluster\_names](#input\_k8s\_cluster\_names) | A list of k8s cluster names that will live in this vpc. We use these to tag vpc resources appropriately. See https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html | `list(string)` | `[]` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | List of IP ranges for the private subnets. Must be same length as var.azs. | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | A high level name, typically the name of the site. | `string` | n/a | yes |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | List of IP ranges for the public subnets. Must be same length as var.azs. | `list(any)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | The service. Aka cloud-env | `string` | n/a | yes |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | `bool` | `false` | no |
| <a name="input_skip_az_checks"></a> [skip\_az\_checks](#input\_skip\_az\_checks) | Do not set to true for new VPCs; used to support legacy VPCs that violate 1:1 az to subnet constraint | `bool` | `false` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | IP address range for the VPC. | `string` | n/a | yes |
| <a name="input_vpc_endpoints"></a> [vpc\_endpoints](#input\_vpc\_endpoints) | List of VPC endpoints to create | <pre>list(object({<br>    enabled = bool<br>    service = string<br>    region  = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_flow_log_retention_in_days"></a> [vpc\_flow\_log\_retention\_in\_days](#input\_vpc\_flow\_log\_retention\_in\_days) | Number of days to retain VPC flow logs. | `number` | `0` | no |
| <a name="input_vpc_name_suffix"></a> [vpc\_name\_suffix](#input\_vpc\_name\_suffix) | Suffix to append to the VPC name, like `-${var.service}`, defaults to blank for backwards compatibility | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs"></a> [azs](#output\_azs) | EC2 availability zones for the VPC. |
| <a name="output_database_route_table_ids"></a> [database\_route\_table\_ids](#output\_database\_route\_table\_ids) | database route table ids |
| <a name="output_database_subnet_group"></a> [database\_subnet\_group](#output\_database\_subnet\_group) | ID of database subnet group |
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | List of IDs of database subnets |
| <a name="output_database_subnets_cidr_blocks"></a> [database\_subnets\_cidr\_blocks](#output\_database\_subnets\_cidr\_blocks) | List of cidr\_blocks of database subnets |
| <a name="output_default_route_table_id"></a> [default\_route\_table\_id](#output\_default\_route\_table\_id) | default route table id |
| <a name="output_elasticache_route_table_ids"></a> [elasticache\_route\_table\_ids](#output\_elasticache\_route\_table\_ids) | elasticache route table ids |
| <a name="output_elasticache_subnet_group"></a> [elasticache\_subnet\_group](#output\_elasticache\_subnet\_group) | ID of elasticache subnet group |
| <a name="output_elasticache_subnets"></a> [elasticache\_subnets](#output\_elasticache\_subnets) | List of IDs of elasticache subnets |
| <a name="output_elasticache_subnets_cidr_blocks"></a> [elasticache\_subnets\_cidr\_blocks](#output\_elasticache\_subnets\_cidr\_blocks) | List of cidr\_blocks of elasticache subnets |
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | The ID of the Internet Gateway |
| <a name="output_intra_route_table_ids"></a> [intra\_route\_table\_ids](#output\_intra\_route\_table\_ids) | intra route table ids |
| <a name="output_nat_ids"></a> [nat\_ids](#output\_nat\_ids) | List of allocation ID of Elastic IPs created for AWS NAT Gateway |
| <a name="output_nat_public_ips"></a> [nat\_public\_ips](#output\_nat\_public\_ips) | List of public Elastic IPs created for AWS NAT Gateway |
| <a name="output_natgw_ids"></a> [natgw\_ids](#output\_natgw\_ids) | List of NAT Gateway IDs |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | private route table ids |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | A list of the private subnet ids. |
| <a name="output_private_subnets_cidr_blocks"></a> [private\_subnets\_cidr\_blocks](#output\_private\_subnets\_cidr\_blocks) | List of cidr\_blocks of private subnets |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | public route table ids |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | A list of the public subnet ids. |
| <a name="output_public_subnets_cidr_blocks"></a> [public\_subnets\_cidr\_blocks](#output\_public\_subnets\_cidr\_blocks) | List of cidr\_blocks of public subnets |
| <a name="output_redshift_route_table_ids"></a> [redshift\_route\_table\_ids](#output\_redshift\_route\_table\_ids) | redshift route table ids |
| <a name="output_redshift_subnet_group"></a> [redshift\_subnet\_group](#output\_redshift\_subnet\_group) | ID of redshift subnet group |
| <a name="output_redshift_subnets"></a> [redshift\_subnets](#output\_redshift\_subnets) | List of IDs of redshift subnets |
| <a name="output_redshift_subnets_cidr_blocks"></a> [redshift\_subnets\_cidr\_blocks](#output\_redshift\_subnets\_cidr\_blocks) | List of cidr\_blocks of redshift subnets |
| <a name="output_vgw_id"></a> [vgw\_id](#output\_vgw\_id) | The ID of the VPN Gateway |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_endpoints"></a> [vpc\_endpoints](#output\_vpc\_endpoints) | VPC endpoint details |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END -->
