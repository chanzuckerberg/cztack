locals {
  resource_name = "${var.project}-${var.env}-${var.service}"
}

data "aws_caller_identity" "current" {}

data "aws_kms_alias" "parameter_store_key" {
  name = "alias/${var.parameter_store_key_alias}"
}

resource "aws_iam_policy" "policy" {
  name        = "${local.resource_name}-parameter-policy"
  description = "Provide access to the parameters of service ${local.resource_name}"
  path        = "${var.iam_path}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Action": [
        "ssm:GetParameters*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:ssm::${data.aws_caller_identity.current.account_id}:parameter/${local.resource_name}/*"
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

  lifecycle {
    ignore_changes = ["name"]
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = "${var.role_name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
