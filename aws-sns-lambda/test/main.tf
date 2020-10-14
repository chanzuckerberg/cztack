resource random_string random {
  length  = 6
  special = false
}


data "archive_file" "notifier" {
  type        = "zip"
  source_file = "${path.module}/hello.py"
  output_path = "${path.module}/hello.zip"
}

module sns-lambda {
  source = "./.."

  lambda_handler = "hello.hello"
  lambda_runtime = "python3.8"

  lambda_zip_file         = data.archive_file.notifier.output_path
  lambda_source_code_hash = data.archive_file.notifier.output_base64sha256

  log_retention_in_days = 1

  project = random_string.random.result
  env     = random_string.random.result
  service = random_string.random.result
  owner   = random_string.random.result
}
