package testutil

const (
	//EnvVPCID is a premade test vpc
	EnvVPCID = "VPC_ID"
	// EnvDatabaseSubnetGroup is a collection of database subnets
	EnvDatabaseSubnetGroup = "DATABASE_SUBNET_GROUP"
	// EnvPrivateSubnets is a comma separated list of private subnets
	EnvPrivateSubnets = "PRIVATE_SUBNETS"
	// EnvVPCCIDRBlock is the premate test vpc CIDR block
	EnvVPCCIDRBlock = "VPC_CIDR_BLOCK"
	// EnvRoute53ZoneID is the premade test route53 zone
	EnvRoute53ZoneID = "ROUTE53_ZONE_ID"
	// EnvRoute53ZoneName is the premate test route53 zone
	EnvRoute53ZoneName = "ROUTE53_ZONE_NAME"
	// EnvWildcardCertARN is a premade test ACM cert
	EnvWildcardCertARN = "WILDCARD_CERT_ARN"
	// EnvWildcardCloudfrontCertARN is a premate test ACM cert in us-east-1
	EnvWildcardCloudfrontCertARN = "CLOUDFRONT_WILDCARD_CERT_ARN"
)
