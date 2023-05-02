
resource "random_pet" "this" {
  keepers = {
    role_name = var.role_name
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    sid = "dynamodb-rw"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:PutItem",
      "dynamodb:DescribeTable",
      "dynamodb:Scan",
    ]

    resources = [
      var.table_arn,
      "${var.table_arn}/*",
    ]
  }
}

resource "aws_iam_policy" "this" {
  name   = "${var.tags.project}-${var.tags.env}-${var.tags.service}-${random_pet.this.id}"
  policy = data.aws_iam_policy_document.this.json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.role_name != null ? 1 : 0

  role       = random_pet.this.keepers.role_name
  policy_arn = aws_iam_policy.this.arn
}
