resource random_string random {
  length  = 6
  special = false
}


data "archive_file" "notifier" {
  type        = "zip"
  source_file = "${path.module}/hello.py"
  output_path = "${path.module}/hello.zip"
}

module lambda {
  source = "../"

  handler = "hello.hello"
  runtime = "python3.8"

  filename         = data.archive_file.notifier.output_path
  source_code_hash = data.archive_file.notifier.output_base64sha256

  project = random_string.random.result
  env     = random_string.random.result
  service = random_string.random.result
  owner   = random_string.random.result
}

output arn {
  value = module.lambda.arn
}

output invoke_arn {
  value = module.lambda.invoke_arn
}
