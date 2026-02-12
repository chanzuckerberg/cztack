output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  description = "A list of the public subnet ids."
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "A list of the private subnet ids."
  value       = module.vpc.private_subnets
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}

output "database_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = module.vpc.database_subnets_cidr_blocks
}

output "database_subnet_group" {
  description = "ID of database subnet group"
  value       = module.vpc.database_subnet_group
}

output "redshift_subnets" {
  description = "List of IDs of redshift subnets"
  value       = module.vpc.redshift_subnets
}

output "redshift_subnets_cidr_blocks" {
  description = "List of cidr_blocks of redshift subnets"
  value       = module.vpc.redshift_subnets_cidr_blocks
}

output "redshift_subnet_group" {
  description = "ID of redshift subnet group"
  value       = module.vpc.redshift_subnet_group
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = module.vpc.elasticache_subnets
}

output "elasticache_subnets_cidr_blocks" {
  description = "List of cidr_blocks of elasticache subnets"
  value       = module.vpc.elasticache_subnets_cidr_blocks
}

output "elasticache_subnet_group" {
  description = "ID of elasticache subnet group"
  value       = module.vpc.elasticache_subnet_group
}

output "nat_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_ids
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = module.vpc.natgw_ids
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.igw_id
}

output "vgw_id" {
  description = "The ID of the VPN Gateway"
  value       = module.vpc.vgw_id
}

output "azs" {
  description = "EC2 availability zones for the VPC."
  value       = var.azs
}

output "database_route_table_ids" {
  value       = module.vpc.database_route_table_ids
  description = "database route table ids"
}

output "default_route_table_id" {
  value       = module.vpc.default_route_table_id
  description = "default route table id"
}

output "elasticache_route_table_ids" {
  value       = module.vpc.elasticache_route_table_ids
  description = "elasticache route table ids"
}

output "intra_route_table_ids" {
  value       = module.vpc.intra_route_table_ids
  description = "intra route table ids"
}

output "private_route_table_ids" {
  value       = module.vpc.private_route_table_ids
  description = "private route table ids"
}

output "public_route_table_ids" {
  value       = module.vpc.public_route_table_ids
  description = "public route table ids"
}

output "redshift_route_table_ids" {
  value       = module.vpc.redshift_route_table_ids
  description = "redshift route table ids"
}

output "vpc_endpoints" {
  description = "VPC endpoint details"
  value = {
    for service, endpoint in aws_vpc_endpoint.vpc_endpoints : service => {
      id                    = endpoint.id
      dns_entries           = endpoint.dns_entry
      network_interface_ids = endpoint.network_interface_ids
    }
  }
}