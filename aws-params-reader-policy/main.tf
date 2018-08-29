locals {
  resource_name = "${var.project}-${var.env}-${var.service}"
}

data "aws_caller_identity" "current" {}

data "aws_kms_alias" "parameter_store_key" {
  name = "alias/${var.parameter_store_key_alias}"
}

resource "aws_iam_role_policy" "policy" {
  name = "${local.resource_name}-parameter-policy"
  role = "${var.role_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Action": [
        "ssm:GetParameters",
        "ssm:GetParametersByPath",
        "ssm:GetParameter",
        "ssm:GetParameterHistory",
        "ssm:DescribeParameters"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${local.resource_name}/*"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
         "kms:Decrypt"
      ],
      "Resource": "${data.aws_kms_alias.parameter_store_key.target_key_arn}"
    }
  ]
}
EOF
}
