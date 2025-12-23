# Uses Kubernetes apiVersion to gather relevant audit logs associated with cluster
module "audit_log_ingest" {
  count                     = var.enable_audit_s3_ingest ? 1 : 0
  source                    = "../aws-firehose-s3-archiver"
  cloudwatch_filter_pattern = "{ $.level = \"Request\"  && $.apiVersion = \"audit.k8s.io/v1\" }"
  bucket_name               = var.logs_bucket_name
  log_group_name            = module.cluster.cloudwatch_log_group_name
  name                      = "${local.cluster_name}_audit_stream"
  s3_prefix                 = "eks-audit-logs/${var.aws_org_id}/${var.tags.env}/${data.aws_caller_identity.current.account_id}/${local.cluster_name}/"
  enable_backup             = false
}
