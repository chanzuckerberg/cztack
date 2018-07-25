resource "aws_iam_group" "login" {
  name = "${var.group_name}"
  path = "${var.iam_path}"
}

# This policy was based on one published by AWS (https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_users-self-manage-mfa-and-creds.html)
# but with a number of modifications. Specifically, we removed the final statement that requires
# MFA for all actions. At some point we'll either add that back or write a more specific "Must use MFA"
# policy.
#
# The other change is that we permit a number of actions which allow users to view IAM data (everyone's).
# This was done to make it easier for users to reason about their (and their teammates') access and
# reduce operational burden.
resource "aws_iam_policy" "self-iam" {
  name        = "self-iam"
  path        = "${var.iam_path}"
  description = ""

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowAllUsersToListUsers",
      "Effect": "Allow",
      "Action": [
        "iam:ListAccountAliases",
        "iam:ListUsers",
        "iam:ListVirtualMFADevices",
        "iam:GetAccountPasswordPolicy",
        "iam:GetAccountSummary",
        "iam:ListUserPolicies",
        "iam:ListAttachedUserPolicies",
        "iam:ListGroupsForUser",
        "iam:ListGroups",
        "iam:ListGroupPolicies",
        "iam:ListAttachedGroupPolicies",
        "iam:GetUser",
        "iam:GetServiceLastAccessedDetails",
        "iam:ListPolicies",
        "iam:ListRoles",
        "iam:GetGroup"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation",
      "Effect": "Allow",
      "Action": [
        "iam:ChangePassword",
        "iam:CreateAccessKey",
        "iam:CreateLoginProfile",
        "iam:DeleteAccessKey",
        "iam:DeleteLoginProfile",
        "iam:GetLoginProfile",
        "iam:ListAccessKeys",
        "iam:UpdateAccessKey",
        "iam:UpdateLoginProfile",
        "iam:ListSigningCertificates",
        "iam:DeleteSigningCertificate",
        "iam:UpdateSigningCertificate",
        "iam:UploadSigningCertificate",
        "iam:ListSSHPublicKeys",
        "iam:GetSSHPublicKey",
        "iam:DeleteSSHPublicKey",
        "iam:UpdateSSHPublicKey",
        "iam:UploadSSHPublicKey",
        "iam:GetAccessKeyLastUsed",
        "iam:ListServiceSpecificCredentials",
        "iam:GenerateServiceLastAccessedDetails",
        "iam:ListPoliciesGrantingServiceAccess"
      ],
      "Resource": "arn:aws:iam::*:user/$${aws:username}"
    },
    {
      "Sid": "AllowIndividualUserToListOnlyTheirOwnMFA",
      "Effect": "Allow",
      "Action": [
        "iam:ListMFADevices"
      ],
      "Resource": [
        "arn:aws:iam::*:mfa/*",
        "arn:aws:iam::*:user/$${aws:username}"
      ]
    },
    {
      "Sid": "AllowIndividualUserToManageTheirOwnMFA",
      "Effect": "Allow",
      "Action": [
        "iam:CreateVirtualMFADevice",
        "iam:DeleteVirtualMFADevice",
        "iam:EnableMFADevice",
        "iam:ResyncMFADevice"
      ],
      "Resource": [
        "arn:aws:iam::*:mfa/$${aws:username}",
        "arn:aws:iam::*:user/$${aws:username}"
      ]
    },
    {
      "Sid": "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA",
      "Effect": "Allow",
      "Action": [
        "iam:DeactivateMFADevice"
      ],
      "Resource": [
        "arn:aws:iam::*:mfa/$${aws:username}",
        "arn:aws:iam::*:user/$${aws:username}"
      ],
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_group_policy_attachment" "self-iam" {
  policy_arn = "${aws_iam_policy.self-iam.arn}"
  group      = "${aws_iam_group.login.name}"
}
