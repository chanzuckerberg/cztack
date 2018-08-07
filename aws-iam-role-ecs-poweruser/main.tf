resource "aws_iam_role" "ecs-poweruser" {
  name = "${var.role_name}"
  path = "${var.iam_path}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${var.source_account_id}:root"
    },
    "Action": "sts:AssumeRole"
  }
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-fullaccess" {
  role       = "${aws_iam_role.ecs-poweruser.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerServiceFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecr-poweruser" {
  role       = "${aws_iam_role.ecs-poweruser.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_policy" "secrets" {
  name        = "${var.role_name}-secrets"
  path        = "${var.iam_path}"
  description = "Provide access to the parameters of service ${var.role_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ssm",
      "Action": [
        "ssm:GetParameter",
        "ssm:GetParameterHistory",
        "ssm:GetParameters",
        "ssm:GetParametersByPath",
        "ssm:DescribeParameters"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "kms",
      "Effect": "Allow",
      "Action": [
         "kms:Decrypt"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "secrets" {
  role       = "${aws_iam_role.ecs-poweruser.name}"
  policy_arn = "${aws_iam_policy.secrets.arn}"
}
