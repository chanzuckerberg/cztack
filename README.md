# CZtack

Cztack (pronounced "stack") is CZI's collection of Terraform modules. We use these as way to scale our infrastructure work.

## Design Principles

TODO

## Modules

### AWS Default VPC security

This will name, tag, and optionall lock down AWS default VPCs.

[Read More](aws-default-vpc-security/README.md)

### AWS IAM ECS Task Role

This creates a role for use with an ECS task, you bring your own policy and we create the role for you.

[Read More](aws-iam-ecs-task-role/README.md)

### AWS IAM Group assume-role

This module with create and IAM group, add users to it and grant the grouop permission to assume a role. This is commonly used for cross-account access control.

[Read More](aws-iam-group-assume-role/README.md)

### AWS IAM Group console-login

This will create a group, add users to it, and grant permission to log into the AWS console and manage one's own credentials.

[Read More](aws-iam-group-console-login/README.md)

### AWS IAM password policy

This module will create a good password policy for your AWS account.

[Read More](aws-iam-password-policy/README.md)

### AWS IAM cloudwatch logs policy

This will create a policy that allow writing to cloudwatch logs.

[Read More](aws-iam-policy-cwlogs/README.md)

### AWS IAM poweruser role

This will create a poweruser role, based off the AWS-managed "poweruser" policy, but with a few additions that we find useful.

[Read More](aws-iam-poweruser/README.md)

### AWS IAM Role Cloudfront poweruser

This will create a role that gives "poweruser" level access to cloudfront.

[Read More](aws-iam-role-cloudfront-poweruser/README.md)

### AWS IAM Role ECS poweruser

This will create a role that gives "poweruser" level access to ECS.

[Read More](aws-iam-role-ecs-poweruser/README.md)

### AWS IAM Role infraci

This is a role we find useful for running CI jobs for terraform code. It is based on the AWS-managed policy for readonly, but includes a few additions, like the ability to read secrets.

[Read More](aws-iam-role-infraci/README.md)

### AWS IAM role readonly

This creates a readonly role, based off the AWS-managed readonly policy, but with a few changes.

[Read More](aws-iam-role-readonly/README.md)

### AWS IAM role security-audit

This creates a security-audit role, based off the AWS-managed policy, but with a few changes.

[Read More](aws-iam-role-security-audit/README.md)