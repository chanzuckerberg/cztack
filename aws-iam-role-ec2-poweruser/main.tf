data "aws_iam_policy_document" "assume-role" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.source_account_id}:root"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2-poweruser" {
  name               = "${var.role_name}"
  path               = "${var.iam_path}"
  assume_role_policy = "${data.aws_iam_policy_document.assume-role.json}"
}

data "aws_iam_policy_document" "ec2" {
  statement {
    sid       = "ec2"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2" {
  name        = "${var.role_name}-ec2"
  description = "Provides full access to the ec2 api"
  path        = "${var.iam_path}"
  policy      = "${data.aws_iam_policy_document.ec2.json}"
}

resource "aws_iam_role_policy_attachment" "ec2" {
  role       = "${aws_iam_role.ec2-poweruser.name}"
  policy_arn = "${aws_iam_policy.ec2.arn}"
}
