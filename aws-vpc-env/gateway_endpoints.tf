data "aws_region" "current" {}

# S3 and DynamoDB Gateway VPC Endpoints — attaches to private and database
# route tables so that same-region traffic is routed directly rather than
# through the NAT gateway ($0.045/GB). Gateway endpoints are free and have
# no per-request overhead.

resource "aws_vpc_endpoint" "s3_gateway" {
  count             = var.enable_s3_gateway_endpoint ? 1 : 0
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = concat(
    module.vpc.private_route_table_ids,
    module.vpc.public_route_table_ids,
    module.vpc.database_route_table_ids,
  )

  tags = local.tags
}

resource "aws_vpc_endpoint" "dynamodb_gateway" {
  count             = var.enable_dynamodb_gateway_endpoint ? 1 : 0
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids = concat(
    module.vpc.private_route_table_ids,
    module.vpc.public_route_table_ids,
    module.vpc.database_route_table_ids,
  )

  tags = local.tags
}
