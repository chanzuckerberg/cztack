# Changelog

## 0.30.0 2020-03-31

* [50ef023c](../../commit/50ef023cecef2b9c2c55cfe78e5323dd3df82796) [feature] aws-iam-role-*: Allow multiple accounts to assume role, deprecate source_account_id ([#185](../../pull/185))
* [4fcd6f92](../../commit/4fcd6f92521c64e3e7c2496c3faedbfc5180edf5) upgraded to go 1.14 ([#184](../../pull/184))
* [b31cd721](../../commit/b31cd721d79be8a927d36a5b62b3fcedbf4fbe86) [breaking] [feature] aws-iam-instance-profile reuse existing role and remove SSM support ([#183](../../pull/183))
* [8d7f1ff8](../../commit/8d7f1ff82a72b910530df8f71dcab6d9359e13ca) Update docstrings ([#182](../../pull/182))

## 0.29.0 2020-03-17

* [72fe3a70](../../commit/72fe3a7011ece3af372cf150e3635bec8e4b9d4c) [feature] Allow the aws-iam-role-crossacct for OIDC federation ([#179](../../pull/179))
* [968da0b0](../../commit/968da0b00ff5be389278759f24fb17659165a8e4) retry downloading dependencies ([#178](../../pull/178))
* [b770f3df](../../commit/b770f3df41660de1a9973bca03dbd9357affa089) add git push to release

## 0.25.0 2019-12-10

* [e6b42dd1](../../commit/e6b42dd1e8cc308cbfeaad814bdf668d1bae9694) Updating VERSION file to 0.24.0
* [39aa6fac](../../commit/39aa6facd9ebc5d9d869817ee1a6e491dbc9417c) enforcing SSL for every action ([#157](../../pull/157))
* [190c3c29](../../commit/190c3c29500563e4d976f839b1ffd8bf4c31800f) [feature] lifecycle policy for s3 buckets ([#156](../../pull/156))

## 0.24.0 2019-11-27

* [c59aa0e3](../../commit/c59aa0e37a7e52bb66ede87fca9515f8dc8fb768) [feature] Adds support for SAML trust relationship to existing roles ([#154](../../pull/154))
* [8bc7c988](../../commit/8bc7c9882c0cbb8ec328c774d9b9fe913f893fe5) Adding a generic .editorconfig. https://editorconfig.org/ ([#152](../../pull/152))
* [e1df3558](../../commit/e1df355811a259a9d6c6a66250fcee3a21dd2a12) add db param groups to list of things that can be nuked ([#153](../../pull/153))
* [39f66dcc](../../commit/39f66dccfabd8702187daf7fbc168dbcebd6df0b) Add slow_start parameter to ecs-service-with-alb ([#151](../../pull/151))
* [7fcf7337](../../commit/7fcf73374a90734c4d93e2acc9cded9db93ac77b) speed up build by paritioning ([#150](../../pull/150))

## 0.23.0 2019-10-17

* [cf652857](../../commit/cf652857014c729efb338aeee637875a88d606ed) [breaking] Fix aws-redis-node security groups ([#149](../../pull/149))
* [13056bad](../../commit/13056badbb543697a5b2885180204e9b4a88e9ad) Allow restricting aws-aurora ingress by security groups ([#148](../../pull/148))
* [20df8cf1](../../commit/20df8cf1b27670a3dc4f8895d6a1e9b17d5f5e86) upgraded to go 1.13.1 ([#147](../../pull/147))

## 0.22.2 2019-10-10

* [61d294b5](../../commit/61d294b57fdc12c795d995864574059b65f17172) Add UpdateRoleDescription perms to aws-iam-role-poweruser ([#145](../../pull/145))
* [4dee504e](../../commit/4dee504e75885a37df6dc4776dba00fc35d6fb7a) [bugfix] Fix secretsmanager execution role IAM policy in aws-ecs-job ([#144](../../pull/144))
* [3f3b0f55](../../commit/3f3b0f55376216dc520800166dcc22f3521a6681) Make aws-redis-node match internal lib, upgrade default ([#146](../../pull/146))

## 0.22.1 2019-10-09

* [133cb5c3](../../commit/133cb5c3ab7a3671f4212fe1e28476e675247247) [bugfix] fix permissions on aws-ecs-service secrets ([#143](../../pull/143))

## 0.22.0 2019-10-08

* [093abc49](../../commit/093abc491ab7fdbc1693d8360da3a386dd81f7fe) aws-ecs Add support for ordered_placement_strategy ([#139](../../pull/139))
* [d832ad1f](../../commit/d832ad1fa2520a2d0069ea7ca113ce749e68994c) Add tags to IAM roles ([#142](../../pull/142))
* [499fed7b](../../commit/499fed7ba1cce9f5edb5aa0a3e6165b5753ef0f8) [fix] aws-ecs support not applying tags to services ([#140](../../pull/140))
* [49209981](../../commit/49209981d40c8d7eb2cbf57b52034103dceb528b) Output ALB listener ARNs from aws-ecs-service ([#141](../../pull/141))
* [f4e551ed](../../commit/f4e551ed0b5020c3b19ce5a833136092fc50cd20) aws-acm-cert Add workaround for TF bug ([#138](../../pull/138))

## 0.21.3 2019-10-02

* [29f3f4cb](../../commit/29f3f4cbe64fd3fcbcec95e4c02b77c1910e3b47) aws-ecs-service fix service discovery arn ([#137](../../pull/137))
* [cf3d830a](../../commit/cf3d830a690bcbfd49f8eb17b8af8b23eb2bff15) Add Name tags to cloudwatch logs ([#136](../../pull/136))

## 0.21.2 2019-09-27

* [da0ca125](../../commit/da0ca125165c380fbb52d2d283b07a17e209695e) upgraded to go 1.13 ([#135](../../pull/135))
* [b2809c4d](../../commit/b2809c4d01903cf76caac4cc2339f45773bca944) [bugfix] aws-ecs-service fix type of cidr_blocks ([#134](../../pull/134))

## 0.21.1 2019-09-26

* [57354a7f](../../commit/57354a7f702af6ed6501564d038d561b63afbde4) Fix aws-ecs-* task execution role permissions ([#133](../../pull/133))

## 0.21.0 2019-09-25

* [6918848f](../../commit/6918848f1dab99c67e49d21bdc839d907ff8b647) [feature] Add ECS modules to cztack ([#132](../../pull/132))

## 0.20.0 2019-09-23

* [9bcd84c7](../../commit/9bcd84c74a2a26fe4ccfbb32bc8347bd4c0fa5e8) [breaking] Modified infraci role to accept a list of dyanmodb table arns ([#130](../../pull/130))

## 0.19.5 2019-09-23

* [04f67e0f](../../commit/04f67e0fec7bdf76427cf30e193c5508e8aeb801) Adding terraform statefile policy to infraci role ([#126](../../pull/126))

## 0.19.4 2019-09-18

* [fbfaf513](../../commit/fbfaf5134197f67c437b2f7f6dd308e1a940b7af) Add internal features to aws-single-page-static-site ([#125](../../pull/125))

## 0.19.3 2019-09-17

* [2faeae6c](../../commit/2faeae6c8163c395207b6d4ecc935664d8b302b7) aws-s3-private-bucket set ignore_public_acls and restrict_public_buckets ([#124](../../pull/124))

## 0.19.2 2019-09-16

* [6923e1b6](../../commit/6923e1b62582134e4f19af34bf30f2b2520a016f) Support disabling versioning in private buckets ([#122](../../pull/122))
* [96ea06d9](../../commit/96ea06d9ebd3fbd5859fe034f4740acfd8fb3b88) Support multiple services in params reader policy ([#121](../../pull/121))
* [6765b83c](../../commit/6765b83c4cb9fc7170b1847b57523c44ce9f1400) Fix typo in aws-s3-private-bucket ([#120](../../pull/120))

## 0.19.1 2019-09-12

* [af52ae6e](../../commit/af52ae6e84151f3a5eb6e11373dfa1337102fbd9) Make Aurora engine version configurable ([#118](../../pull/118))
* [ddf566a2](../../commit/ddf566a27e43eb35bd4a8c34a77499dc8c919892) Add Aurora deletion protection variable ([#116](../../pull/116))
* [384ed745](../../commit/384ed74535d44b32a2962adecd73ac88d3d574a5) Add cloudfront outputs for single-page-static-site ([#115](../../pull/115))

## 0.19.0 2019-08-20

* [f827caa5](../../commit/f827caa5894ee9a9bbb0ad8ac4caa89d9b95a912) [fix] Added more information to the github webhooks collector Readme ([#113](../../pull/113))
* [22e21f1a](../../commit/22e21f1ad3ed47710fa56060efc74a5c531c574f) [feature] Add GitHub Webhooks archiver and S3 private bucket modules ([#112](../../pull/112))

## 0.18.2 2019-08-13

* [c3f8d58e](../../commit/c3f8d58ee8f443f8042890588523e7ce7b766d0d) Add aws-ssm-params and aws-ssm-params-writer ([#111](../../pull/111))
* [5c845fff](../../commit/5c845fff5009bae70f723d2260737b70f236af75)  set engine_version for aws-aurora-postgres ([#110](../../pull/110))

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
