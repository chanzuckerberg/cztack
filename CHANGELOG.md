# Changelog

## 0.18.1 2019-08-08

* [d7d8c044](../../commit/d7d8c044c30f44b685d46a3343d3285b1249b8d4) added action for poweruser accountalias ([#108](../../pull/108))

## 0.18.0 2019-07-29
* [4f94667](../../commit/4f946675d74b2a3a3244926c1cc054222122c97f) Release 0.18.0
* [878f367](../../commit/878f367bd8f76b54b00820e1b8d6b050509293ee) [breaking] Terraform 0.12 compatibility (breaks 0.11 compatibility) (#105)
* [f6e470b](../../commit/f6e470bdcc0ef23975626ec024be746d3b4f8568) Fixed Typo in Readme (#102)
* [b9000b8](../../commit/b9000b89797171454478d850443831ee1c1e16cd) Add a .gitattributes to collapsed vendored code during github pull requests (#106)
* [d0e53fc](../../commit/d0e53fc1387b864c75fe00b6cdb7f49b7e95a73f) add force_detach_policies to aws_iam_role (#100)
* [982ff3b](../../commit/982ff3b024647afb8e8a43da68bc0ae48adaebf3) ACM certificate route53 overwrite (#99)

## 0.17.1 2019-05-15
* [bdad602](../../commit/bdad6029c940da121eef5bf212030215c51fa1f6) adding in route53 Read Only Access (#96)
* [a361c8d](../../commit/a361c8d19d7df3e1a18f0810a48a1467b26b4998) Create pull request template.md

## 0.17.0 2019-05-01
* [1fc4a19](../../commit/1fc4a19e24acb262d7008c5ee39cef331da37cfe) New route53 poweruser (#94)
* [8fc7bf0](../../commit/8fc7bf06459c49b321ee0d5a57b1491a22f15f45) [breaking] Removing ability of power users to register domains via route53 (#92)

## 0.16.0 2019-04-22
* [9d5798e](../../commit/9d5798e3a0ff47602b7db6343dfd114cdbf5c8fa) Update aws-params-writer to explicitly take a parameters count (#90)
* [57261e8](../../commit/57261e8e88f13f0b4d8ea5e7878342e08bc59e90) Add iam:ListServerCertificates permission to poweruser (#89)
* [cbaa829](../../commit/cbaa829ebfb6856b14a7fe339522c114d8dd1e33) Fix a bug with missing param group connection to the Aurora resource (#88)

## 0.15.3 2019-01-30
* 00061db [Bugfix] Limit SSM s3 policies (#85)
* 418e527 [Bugfix] Changed policy for readonly to include secrets policy (#84)
* 60203ad Add iam:TagRole to poweruser (#83)

## 0.15.2 2018-12-05
* `aws-iam-ec2-poweruser-role` Add iam_path
* `aws-iam-ecs-task-role` Add iam_path
* `aws-iam-instance-profile` Add option to disable attach SSM policy
* `aws-iam-role-infraci` Add secrets manager read access to secrets tagged with allowCI=true
* `aws-aurora-*` Expose the reader endpoint*

## 0.15.1 2018-11-09
* Bugfix for aws_iam_policy_document in aws-iam-group-assume-role

## 0.15.0 2018-11-08
* [new] aws single page app static site
* [new] aws-iam-instance-profile
* [new] bless-ca
* [breaking] KMS key tags
* [breaking] aws-iam-ecs-task-role remove policy argument
* Poweruser delete/update policy permissions
* Convert raw JSON policy to aws_iam_policy_document

## 0.14.0 2018-09-04
* [breaking] Parameter store reader policy inline, region support
* Poweruser instance profile and policy permissions
* Testing for aws-redis-node and aurora

## 0.13.0 2018-08-21
* [breaking] cloudfront poweruser allow for multiple bucket prefixes
* [new] cloudwatch log group module
* [new] [blessclient](https://github.com/lyft/python-blessclient) aws role


## 0.12.0 2018-08-15
* added a suite of tests via Terratest
* [new] module for ec2 poweruser role
* [new] modules for aws aurora
* better docs for our taggging approach
* [breaking] refactor of params/secrets modules
* [new] AWS ACM cert module

## 0.11.0 2018-07-30

Initial release of open source modules. Number is kept in-sync with internal repo.

Currently moved to this repo are all our IAM and secrets modules.
