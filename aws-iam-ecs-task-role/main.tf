data "aws_iam_policy_document" "role" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "${var.project}-${var.env}-${var.service}"
  description        = "Task role for ${var.service} task in ${var.project}-${var.env}. Owned by ${var.owner}."
  assume_role_policy = "${data.aws_iam_policy_document.role.json}"
  path               = "${var.iam_path}"
}
