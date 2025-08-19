variables {
  cluster_name = "core-platform-nonprod-eks"
  sqs_name     = "test-sqs-queue"
  tags = {
    env       = "test-env"
    managedBy = "test-team"
    owner     = "test-team"
    project   = "test-project"
    service   = "test-service"
  }
}

run "plan_validation" {
  command = plan
  assert {
    condition     = aws_sqs_queue.sqs_queue.name == "test-sqs-queue"
    error_message = "SQS queue name did not match expected"
  }
  assert {
    condition     = aws_iam_role.sqs_queue_iam_role.name == "test-sqs-queue-role"
    error_message = "The IAM role name did not match expected"
  }
}


run "sqs_queue_properties" {
  command = apply
  assert {
    condition     = aws_sqs_queue.sqs_queue.name == "test-sqs-queue"
    error_message = "SQS queue name is not correct."
  }
  assert {
    condition     = aws_sqs_queue.sqs_queue.tags.env == "test-env"
    error_message = "SQS queue tag 'env' is missing or incorrect."
  }
}


# # run "iam_role_properties" {
# #   fixture = mock_aws_environment

# #   command = apply
# #   assert {
# #     condition     = aws_iam_role.sqs_queue_iam_role.name == "test-sqs-queue-role"
# #     error_message = "IAM role name is not correct."
# #   }
# #   assert {
# #     condition     = can(aws_iam_role_policy_attachment.sqs_policy_attachment)
# #     error_message = "IAM policy attachment does not exist."
# #   }
# # }
