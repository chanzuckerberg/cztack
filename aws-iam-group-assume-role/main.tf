locals {
  account_arns = "${formatlist("arn:aws:iam::%s:role/${var.target_role == "" ? var.group_name : var.target_role}", var.target_accounts)}"
}

resource "aws_iam_group" "assume-role" {
  name = "${var.group_name}"
  path = "${var.iam_path}"
}

resource "aws_iam_group_membership" "assume-role" {
  name  = "${var.group_name}"
  users = ["${var.users}"]
  group = "${aws_iam_group.assume-role.name}"

  # depends_on = ["null_resource.dependency_getter"]
}

resource "aws_iam_policy" "assume-role" {
  name        = "${var.group_name}"
  path        = "${var.iam_path}"
  description = ""
  policy      = "${data.aws_iam_policy_document.assume-role.json}"
}

data "aws_iam_policy_document" "assume-role" {
  statement {
    sid       = "assume0"
    resources = ["${local.account_arns}"]
    actions   = ["sts:AssumeRole"]
  }
}

resource "aws_iam_group_policy_attachment" "assume-role" {
  policy_arn = "${aws_iam_policy.assume-role.arn}"
  group      = "${aws_iam_group.assume-role.name}"
}

# # https://github.com/hashicorp/terraform/issues/1178
# Commented out local-provisioner that would actually enforce dependencies
# because Terraform was running into "too many files open" in czi-id


# # Pseudo dependencies to ensure dependencies actually get enforced
# resource "null_resource" "dependency_getter" {
#   provisioner "local-exec" {
#     command = "echo ${length(var.dependencies)}"
#   }
# }


# resource "null_resource" "dependency_setter" {
#   depends_on = [
#     # List resource(s) that will be constructed last within the module.
#     aws_iam_group_policy_attachment.assume-role,
#     aws_iam_policy.assume-role,
#     aws_iam_group_membership.assume-role,
#     aws_iam_group.assume-role
#   ]
# }

