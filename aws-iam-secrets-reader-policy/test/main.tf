resource random_string name {
  length  = 6
  special = false
}

resource random_string not {
  length  = 6
  special = false
}

data aws_caller_identity cur {}

resource aws_iam_role role {
  name               = random_string.name.result
  assume_role_policy = <<JSON
{
		"Version": "2012-10-17",
		"Statement": {
			"Effect": "Allow",
			"Principal": {
			"AWS": "arn:aws:iam::${data.aws_caller_identity.cur.account_id}:root"
			},
			"Action": "sts:AssumeRole"
		}
		}
JSON
}

resource aws_iam_role not {
  name               = random_string.not.result
  assume_role_policy = <<JSON
{
		"Version": "2012-10-17",
		"Statement": {
			"Effect": "Allow",
			"Principal": {
			"AWS": "arn:aws:iam::${data.aws_caller_identity.cur.account_id}:root"
			},
			"Action": "sts:AssumeRole"
		}
		}
JSON
}

resource aws_secretsmanager_secret secret {
  name = random_string.name.result
}

resource aws_secretsmanager_secret_version ver {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = "my secret"
}

resource aws_secretsmanager_secret not {
  name = random_string.not.result
}

resource aws_secretsmanager_secret_version not {
  secret_id     = aws_secretsmanager_secret.not.id
  secret_string = "my secret"
}

module policy {
  source = "../"

  role_name    = aws_iam_role.role.name
  secrets_arns = [aws_secretsmanager_secret.secret.arn]
}

output role {
  value = aws_iam_role.role.arn
}

output not_role {
  value = aws_iam_role.not.arn
}

output secret {
  value = aws_secretsmanager_secret.secret.arn
}

output not_secret {
  value = aws_secretsmanager_secret.not.arn
}
