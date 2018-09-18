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

data "aws_iam_policy_document" "self-iam" {
  statement {
    sid = "AllowAllUsersToListUsers"

    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:GetGroup",
      "iam:GetServiceLastAccessedDetails",
      "iam:GetUser",
      "iam:ListAccountAliases",
      "iam:ListAttachedGroupPolicies",
      "iam:ListAttachedUserPolicies",
      "iam:ListGroupPolicies",
      "iam:ListGroups",
      "iam:ListGroupsForUser",
      "iam:ListPolicies",
      "iam:ListRoles",
      "iam:ListUserPolicies",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
    ]

    resources = ["*"]
  }

  statement {
    sid = "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation"

    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:DeleteSSHPublicKey",
      "iam:DeleteSigningCertificate",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:GetAccessKeyLastUsed",
      "iam:GetLoginProfile",
      "iam:GetSSHPublicKey",
      "iam:ListAccessKeys",
      "iam:ListPoliciesGrantingServiceAccess",
      "iam:ListServiceSpecificCredentials",
      "iam:ListSSHPublicKeys",
      "iam:ListSigningCertificates",
      "iam:UpdateAccessKey",
      "iam:UpdateLoginProfile",
      "iam:UpdateSSHPublicKey",
      "iam:UpdateSigningCertificate",
      "iam:UploadSSHPublicKey",
      "iam:UploadSigningCertificate",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid     = "AllowIndividualUserToListOnlyTheirOwnMFA"
    actions = ["iam:ListMFADevices"]

    resources = [
      "arn:aws:iam::*:mfa/*",
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }

  statement {
    sid = "AllowIndividualUserToManageTheirOwnMFA"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
    ]

    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }

  statement {
    sid     = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA"
    actions = ["iam:DeactivateMFADevice"]

    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
      "arn:aws:iam::*:user/$${aws:username}",
    ]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_policy" "self-iam" {
  name        = "${var.group_name}-self-iam"
  path        = "${var.iam_path}"
  description = ""
  policy      = "${data.aws_iam_policy_document.self-iam.json}"

  lifecycle {
    ignore_changes = ["name"]
  }
}

resource "aws_iam_group_policy_attachment" "self-iam" {
  policy_arn = "${aws_iam_policy.self-iam.arn}"
  group      = "${aws_iam_group.login.name}"
}
