# Changelog

## 0.41.0 2021-07-08

* [ae62854c](../../commit/ae62854c3dcf8787298fd016f44ad984beca268c) [fix] Various fixes for TF AWS 3.0 compatibility ([#324](../../pull/324))
* [9991541d](../../commit/9991541d5a6789a1e778b994b17c13a1d2bb1737) [feature] Add 'snapshot_identifier' to all aws-aurora modules ([#323](../../pull/323))

## 0.40.0 2021-07-07

* [118ad1c4](../../commit/118ad1c481b292bc262bfaccb4f5d8373b975d39) [feature] Terraform AWS Provider 3.0 compatibility ([#322](../../pull/322))
* [d49054c9](../../commit/d49054c9397ea83244f953f9b8f17fbdd2fbb8fa) [feature] aws-acm-certificate module compatible with TF AWS Provider >3.0 ([#321](../../pull/321))

## 0.39.0 2021-06-25

* [5b963f73](../../commit/5b963f7342aa4c5fce58a7927dc585bf735b6215) Update CODEOWNERS
* [b71a885f](../../commit/b71a885f73472340541c8cb9f7bc1f5e279538a4) remove vestiges of interpolation syntax that was deprecated in TF v0.12+ ([#316](../../pull/316))
* [408e99d5](../../commit/408e99d550663b493697d42f0446fb944013e4f4) Bump github.com/aws/aws-sdk-go from 1.37.25 to 1.38.64 ([#315](../../pull/315))
* [f1550ece](../../commit/f1550ece331be5e210e3826328a9ebd5b4c56581) Bump github.com/sirupsen/logrus from 1.8.0 to 1.8.1 ([#310](../../pull/310))
* [12793de6](../../commit/12793de6c64cc14b0bf86df73d1c642c03774f9e) [breaking] aws-aurora-postgres: Disable auto minor version upgrade by default. ([#311](../../pull/311))
* [98fca6f2](../../commit/98fca6f2e4b016fde20db637a0553684c78c069d) Fix running aws cli on GH Actions/Azure, get modules dynamically ([#309](../../pull/309))
* [e68091be](../../commit/e68091beeab198c6b8fe310e1482384fbc5d7774) Auto merge main branch on update for branches with auto-merge enabled ([#306](../../pull/306))
* [14ec2cc7](../../commit/14ec2cc76f376f9b4f1c24d4a28432e40945a933) Update docs to use Terraform docs v0.12.1 ([#308](../../pull/308))
* [b8bacdb7](../../commit/b8bacdb7ae70623f7dd82999183e67661361cc73) [feature] aws-s3-private-bucket add canned acl variable ([#307](../../pull/307))
* [be13877f](../../commit/be13877f37e570575d5e31a8c598dbe4cd10c891) fix[version]: updating min versions for lambda and cx role ([#305](../../pull/305))
* [c0c5731e](../../commit/c0c5731e3901a2e1bb1fde5c2b3a5337afdb8ac1) Initial updates for supporting s3 bucket logging targets. ([#302](../../pull/302))
* [83e12bc7](../../commit/83e12bc7ea438aed3b9ee16186706a3f5ef21d59) [feature]: lambda vpc_config and memory_size ([#301](../../pull/301))
* [9df43950](../../commit/9df439500dee7468643ca03a844cf7a5b1e1b313) [feature] Allow specifying aws-iam-role max_session_duration ([#299](../../pull/299))
* [06c61e51](../../commit/06c61e51fee2663f4b0aa8bf1aa20f7f7ba30545) Bump github.com/aws/aws-sdk-go from 1.37.16 to 1.37.25 ([#294](../../pull/294))
* [fa775364](../../commit/fa775364294cf15084955c6c538efe7903de4d17) Bump github.com/gruntwork-io/terratest from 0.32.7 to 0.32.8 ([#293](../../pull/293))
* [63a0a896](../../commit/63a0a89603e62a1424813e4ffa6c2cf30f90d071) Bump github.com/sirupsen/logrus from 1.7.0 to 1.8.0 ([#287](../../pull/287))
* [7d3323d1](../../commit/7d3323d163b6a5d08c8fc9bbafb2a98aaaf5098f) Bump github.com/aws/aws-sdk-go from 1.36.3 to 1.37.16 ([#292](../../pull/292))
* [f58ea191](../../commit/f58ea191c816de6198a5a0f69e6f16a78d620b98) Bump github.com/aws/aws-sdk-go from 1.36.3 to 1.37.15 ([#288](../../pull/288))
* [9479aa8a](../../commit/9479aa8a0afd1c2a1d88d9279053f429b8277c12) Create Dependabot config file ([#291](../../pull/291))
* [cd1e33c1](../../commit/cd1e33c101992a92e90003373532d8a895b79f81) Bump github.com/gruntwork-io/terratest from 0.31.1 to 0.32.7 ([#290](../../pull/290))
* [234300b7](../../commit/234300b732355e1efec68bdf42be9163cf87851e) Bump github.com/stretchr/testify from 1.6.1 to 1.7.0 ([#289](../../pull/289))
* [55c16ef9](../../commit/55c16ef9c0fc103757f61a881ea25698b3dbc14a) add go mods auto-tidy workflow
* [298ee9dc](../../commit/298ee9dce9ba2ae2f9174f0dfe3ee1ed84ddb045) [feature] Add CIDR blocks based security group to Redis ([#286](../../pull/286))
* [488c4ea9](../../commit/488c4ea939f100ff59722deaf74c7a1dea912637) [fix] s3-private-bucket more lenient aws provider version ([#285](../../pull/285))
* [e4738500](../../commit/e47385003bb039133c1a5938bf5b67f48823cc48) [refactor] rm unneeded vars ([#281](../../pull/281))
* [9be9388a](../../commit/9be9388a663590540e6933ad50d6f0b76a7fb33f) [fix] aws-single-page-static site to work outside us-east-1 ([#280](../../pull/280))
* [ecdcc6f9](../../commit/ecdcc6f95e1e2d3609b867f299c4306b00e88267) enable clouldwatch log exports for aurora postgresql ([#279](../../pull/279))
* [62f0981e](../../commit/62f0981ef768afb1a8a957c8a45d618db66f89d7) [feature]Snowflake: ALL modules output privileges granted ([#277](../../pull/277))

## 0.38.0 2021-01-12

* [ae34a726](../../commit/ae34a7267539f03468a4d31293848254d9b101d3) [feature] aws-s3-public-bucket require https, allow disabling versioning ([#278](../../pull/278))
* [1b53806c](../../commit/1b53806cbe7022dc7ab15be9843542ba1401a96a) [feature] Add aws-redis-replication-group ([#267](../../pull/267))
* [68ab717a](../../commit/68ab717a5491403b60550be962c736e244b2367f) fix: Snowflake Provider version less strict

## 0.35.0 2020-07-08

* [d87b0071](../../commit/d87b0071e7729697680297d70284c649a0cf13cb) Enable logging with private s3 bucket ([#210](../../pull/210))
* [90a9ec4e](../../commit/90a9ec4e8df882ee226a659de7b6ea25dc67e989) [feature] support auto_minor_version_upgrade ([#209](../../pull/209))
* [fe0d0304](../../commit/fe0d0304138fec1ad9544502809174c6ab1d323b) [feature] Allow overwriting the IAM Role max session duration ([#208](../../pull/208))
* [1fe821e1](../../commit/1fe821e17b01c31d39c00dd186752426064ace57) [fix] [testing] make TDD more productive ([#206](../../pull/206))
* [9c9ef09f](../../commit/9c9ef09f0d1d5d2936a3e732b54647a611c2f884) nuke more resources ([#207](../../pull/207))

## 0.33.1 2020-05-21

* [9d289b25](../../commit/9d289b2563f22b6f9729bc2d88774d4f6b24d224) [fix] Use index when referring to a dependency with a count

## 0.33.0 2020-05-21

* [8b5df1fb](../../commit/8b5df1fbef55cf600c29e23a13ced1799f0ddb61) [feature] Optionally disable poweruser role iam actions ([#194](../../pull/194))
* [d411f6fa](../../commit/d411f6fa40de04957d58de5dd76f1a927caa0091) [feature] Readonly role OIDC federation enabled + kms decrypt optional ([#195](../../pull/195))

## 0.32.0 2020-05-20

* [bd7a4398](../../commit/bd7a439882c733f6cdd6b3e9c58dcd67ee045de4) [feature] AWS Poweruser role allows OIDC sts:AssumeRoleWithWebIdentity ([#192](../../pull/192))
* [28c40d01](../../commit/28c40d0178fedb649d3d738a4a35a676e4883186) Update README.md
* [cfe9771b](../../commit/cfe9771bfd8caf2fca701d75f889116c48eac688) Adding a generic .editorconfig. https://editorconfig.org/ ([#191](../../pull/191))

## 0.31.1 2020-05-01

* [e2c9d0b5](../../commit/e2c9d0b59655a7e76b8367afe88f7a020d6f39ed) Include TagSession privilege for assumed roles. ([#189](../../pull/189))

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
