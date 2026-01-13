# Changelog

## [8.6.0](https://github.com/chanzuckerberg/cztack/compare/aws-eks-cluster-v8.5.2...aws-eks-cluster-v8.6.0) (2026-01-13)


### Features

* add configurable sources options ([#801](https://github.com/chanzuckerberg/cztack/issues/801)) ([07d31dd](https://github.com/chanzuckerberg/cztack/commit/07d31ddb115f3c0ab5042863cff33d9dbbd87f0c))

## [8.5.2](https://github.com/chanzuckerberg/cztack/compare/aws-eks-cluster-v8.5.1...aws-eks-cluster-v8.5.2) (2026-01-12)


### Bug Fixes

* use the addons variable flag for enabling and disabling external dns ([#799](https://github.com/chanzuckerberg/cztack/issues/799)) ([ece4dcd](https://github.com/chanzuckerberg/cztack/commit/ece4dcd4394e011e3011308000a22d420ed030a7))

## [8.5.1](https://github.com/chanzuckerberg/cztack/compare/aws-eks-cluster-v8.5.0...aws-eks-cluster-v8.5.1) (2026-01-08)


### Bug Fixes

* use AL2023 release version name instead of the AMI ID in eks module ([#797](https://github.com/chanzuckerberg/cztack/issues/797)) ([79842d5](https://github.com/chanzuckerberg/cztack/commit/79842d51df2319ebb8dc6975ef73113cbaf48dee))

## [8.5.0](https://github.com/chanzuckerberg/cztack/compare/aws-eks-cluster-v8.4.0...aws-eks-cluster-v8.5.0) (2026-01-07)


### Features

* Enable VPC CNI metric scraping ([#789](https://github.com/chanzuckerberg/cztack/issues/789)) ([29c5c37](https://github.com/chanzuckerberg/cztack/commit/29c5c3757ee3bb7a08f82404eca5bd86e61045f3))


### Bug Fixes

* set al2023 default with right aws ssm parameter path ([#792](https://github.com/chanzuckerberg/cztack/issues/792)) ([e5c55e9](https://github.com/chanzuckerberg/cztack/commit/e5c55e9c739fb5732a2e5d55ebd6d7614b27e778))

## [8.4.0](https://github.com/chanzuckerberg/cztack/compare/aws-eks-cluster-v8.3.1...aws-eks-cluster-v8.4.0) (2025-12-23)


### Features

* move eks-cluster-v2 to cztack ([#783](https://github.com/chanzuckerberg/cztack/issues/783)) ([950a60c](https://github.com/chanzuckerberg/cztack/commit/950a60c67ecef8b7eb965874a5b322201cb27594))

## [8.3.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.3.0...eks-cluster-v2-v8.3.1) (2025-10-02)


### BugFixes

* prevent instance familys for NLB instance target type ([#11463](https://github.com/chanzuckerberg/shared-infra/issues/11463)) ([b0d39e5](https://github.com/chanzuckerberg/shared-infra/commit/b0d39e526ffa78195b02f7edf89c59ddc029cb5c))

## [8.3.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.2.1...eks-cluster-v2-v8.3.0) (2025-09-23)


### Features

* Install s3 csi driver as eks addon ([#11447](https://github.com/chanzuckerberg/shared-infra/issues/11447)) ([64a03fc](https://github.com/chanzuckerberg/shared-infra/commit/64a03fca705c170fcddc42c7c72a45c794d14664))

## [8.2.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.2.0...eks-cluster-v2-v8.2.1) (2025-09-05)


### BugFixes

* remove node affinity and gpu annotation ([#11384](https://github.com/chanzuckerberg/shared-infra/issues/11384)) ([c03aa0b](https://github.com/chanzuckerberg/shared-infra/commit/c03aa0b93a7dba55a4c64f9cdba081ad7760316c))

## [8.2.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.1.3...eks-cluster-v2-v8.2.0) (2025-09-03)


### Features

* More flexibility on instance type ([#11381](https://github.com/chanzuckerberg/shared-infra/issues/11381)) ([8fc3060](https://github.com/chanzuckerberg/shared-infra/commit/8fc306007ea1d66714a650aebe2f46cee0e750a3))
* Upgrade external-dns to v0.19.0 ([#11380](https://github.com/chanzuckerberg/shared-infra/issues/11380)) ([fb57a27](https://github.com/chanzuckerberg/shared-infra/commit/fb57a27bd2a1b88e2d7cbe93e08b8f70c4cb029b))

## [8.1.3](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.1.2...eks-cluster-v2-v8.1.3) (2025-09-03)


### BugFixes

* Add node affinity to jupyterhub profiles ([#11379](https://github.com/chanzuckerberg/shared-infra/issues/11379)) ([a791359](https://github.com/chanzuckerberg/shared-infra/commit/a791359f63f09cd1282896ec0db6da56e7c16dc7))

## [8.1.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.1.1...eks-cluster-v2-v8.1.2) (2025-09-03)


### BugFixes

* expand instance types ([#11374](https://github.com/chanzuckerberg/shared-infra/issues/11374)) ([28a5454](https://github.com/chanzuckerberg/shared-infra/commit/28a54542b69f9e01e3d4b136462819ba0945cce5))

## [8.1.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.1.0...eks-cluster-v2-v8.1.1) (2025-08-29)


### BugFixes

* guaranteed memory value for jupyterhub ([#11369](https://github.com/chanzuckerberg/shared-infra/issues/11369)) ([92855f4](https://github.com/chanzuckerberg/shared-infra/commit/92855f44508e4616d8bf45695e7a7ce6d693f8b8))

## [8.1.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.0.3...eks-cluster-v2-v8.1.0) (2025-08-28)


### Features

* Bump external-dns tag to 0.18.0 ([#11363](https://github.com/chanzuckerberg/shared-infra/issues/11363)) ([78bf99b](https://github.com/chanzuckerberg/shared-infra/commit/78bf99bc99ba78a659a971e6f5240709acad0dbb))
* Migrate external dns ([#11361](https://github.com/chanzuckerberg/shared-infra/issues/11361)) ([1736499](https://github.com/chanzuckerberg/shared-infra/commit/1736499e2c3a2d9bc15c0798a15c564c5a63f41d))
* Update external-dns registry ([#11362](https://github.com/chanzuckerberg/shared-infra/issues/11362)) ([06b3df8](https://github.com/chanzuckerberg/shared-infra/commit/06b3df8d479f47a98bec53cb04051fd4cfc8b68b))

## [8.0.3](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.0.2...eks-cluster-v2-v8.0.3) (2025-08-27)


### BugFixes

* Wait on ESO helm chart to be created ([#11357](https://github.com/chanzuckerberg/shared-infra/issues/11357)) ([1460f34](https://github.com/chanzuckerberg/shared-infra/commit/1460f343efbfdffc3317af24b59637539d4147fc))

## [8.0.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.0.1...eks-cluster-v2-v8.0.2) (2025-08-25)


### BugFixes

* Explicitly specify EBS driver role ([#11350](https://github.com/chanzuckerberg/shared-infra/issues/11350)) ([25c57b3](https://github.com/chanzuckerberg/shared-infra/commit/25c57b345d349a1deb7f43653e1f7baab53fd904))

## [8.0.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v8.0.0...eks-cluster-v2-v8.0.1) (2025-08-12)


### BugFixes

* Allow ECR pull through cache upstream image pulls ([#11305](https://github.com/chanzuckerberg/shared-infra/issues/11305)) ([87926ba](https://github.com/chanzuckerberg/shared-infra/commit/87926ba5d651f061effb24606a5fd7f7502629b3))

## [8.0.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.14.0...eks-cluster-v2-v8.0.0) (2025-08-08)


### ⚠ BREAKING CHANGES

* Split EKS blueprint addon creation to allow karpenter nodepool creation before workloads are scheduled ([#11250](https://github.com/chanzuckerberg/shared-infra/issues/11250))

### Features

* Split EKS blueprint addon creation to allow karpenter nodepool creation before workloads are scheduled ([#11250](https://github.com/chanzuckerberg/shared-infra/issues/11250)) ([fee82ca](https://github.com/chanzuckerberg/shared-infra/commit/fee82ca34ac9f213909fc69e47b25526c9b45889))

## [7.14.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.13.3...eks-cluster-v2-v7.14.0) (2025-07-30)


### Features

* Add memory request for 512gb nodes ([#11251](https://github.com/chanzuckerberg/shared-infra/issues/11251)) ([9cc272f](https://github.com/chanzuckerberg/shared-infra/commit/9cc272f83bf8dab50e78b41e8860d8419caabe27))


### BugFixes

* jupyterhub-values uses the right memory field ([#11253](https://github.com/chanzuckerberg/shared-infra/issues/11253)) ([a86bf55](https://github.com/chanzuckerberg/shared-infra/commit/a86bf55ed8115741ffeb632b186916c3adbb44a5))

## [7.13.3](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.13.2...eks-cluster-v2-v7.13.3) (2025-07-11)


### BugFixes

* whitelist AL2023_ARM_64_NVIDIA as allowed EKS ami ([#11211](https://github.com/chanzuckerberg/shared-infra/issues/11211)) ([6be4de8](https://github.com/chanzuckerberg/shared-infra/commit/6be4de85cf5fd863494decc7ad8540e18e9e18b3))

## [7.13.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.13.1...eks-cluster-v2-v7.13.2) (2025-05-30)


### BugFixes

* Increase karpenter node consolidation to 24h to avoid constant churn ([#11100](https://github.com/chanzuckerberg/shared-infra/issues/11100)) ([0b5e965](https://github.com/chanzuckerberg/shared-infra/commit/0b5e96543468dd2f3cd0cc41960208b5b18c626d))

## [7.13.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.13.0...eks-cluster-v2-v7.13.1) (2025-05-15)


### BugFixes

* Shorten eks node group prefix ([#11050](https://github.com/chanzuckerberg/shared-infra/issues/11050)) ([0f082ea](https://github.com/chanzuckerberg/shared-infra/commit/0f082ea2e7f58f00648293befe5b9140e7d94192))

## [7.13.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.12.1...eks-cluster-v2-v7.13.0) (2025-05-14)


### Features

* Migrate EOL AL2 AMI types to AL2023 ([#11045](https://github.com/chanzuckerberg/shared-infra/issues/11045)) ([99066ef](https://github.com/chanzuckerberg/shared-infra/commit/99066ef8f331c6d21c57d677af49cd7f79d31643))

## [7.12.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.12.0...eks-cluster-v2-v7.12.1) (2025-04-29)


### BugFixes

* clear env-level filepath division for cluster logs ([#10972](https://github.com/chanzuckerberg/shared-infra/issues/10972)) ([d8885aa](https://github.com/chanzuckerberg/shared-infra/commit/d8885aab2f2a9249f8d19ccc603f0c700aa1cb06))

## [7.12.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.11.0...eks-cluster-v2-v7.12.0) (2025-04-16)


### Features

* set up audit logs collection from cluster-v2 modules (storage + filtering + delivery) ([#10823](https://github.com/chanzuckerberg/shared-infra/issues/10823)) ([12ef360](https://github.com/chanzuckerberg/shared-infra/commit/12ef360033e59fef657e4f61e01b81715904d7ce))

## [7.11.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.10.1...eks-cluster-v2-v7.11.0) (2025-04-08)


### Features

* add a graceful termination period for karpenter ([#10871](https://github.com/chanzuckerberg/shared-infra/issues/10871)) ([3428cce](https://github.com/chanzuckerberg/shared-infra/commit/3428cce72c72378de36bb1c358d1a36293e23e5f))

## [7.10.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.10.0...eks-cluster-v2-v7.10.1) (2025-03-14)


### BugFixes

* update external dns policy from upsert-only to sync ([#10805](https://github.com/chanzuckerberg/shared-infra/issues/10805)) ([7d8e12b](https://github.com/chanzuckerberg/shared-infra/commit/7d8e12b1ad16322fc363047dfa9f6f200da94b7a))

## [7.10.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.9.0...eks-cluster-v2-v7.10.0) (2025-02-28)


### Features

* Do not allow pod admission until efs and ebs drivers are ready ([#10745](https://github.com/chanzuckerberg/shared-infra/issues/10745)) ([84d4b64](https://github.com/chanzuckerberg/shared-infra/commit/84d4b642b639d4bb77a02bcb5d743f75aae013a3))

## [7.9.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.8.0...eks-cluster-v2-v7.9.0) (2025-02-27)


### Features

* Pass tags into EKS blueprints ([#10504](https://github.com/chanzuckerberg/shared-infra/issues/10504)) ([3cf4f5d](https://github.com/chanzuckerberg/shared-infra/commit/3cf4f5da1eba384bf832dbfdbf3a94afac85d788))

## [7.8.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.7.0...eks-cluster-v2-v7.8.0) (2025-02-18)


### Features

* Add new user profile for jupyterhub gpus ([#10705](https://github.com/chanzuckerberg/shared-infra/issues/10705)) ([764952c](https://github.com/chanzuckerberg/shared-infra/commit/764952c06e08c113d58e9bd93e3258e3f64dc828))

## [7.7.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.6.1...eks-cluster-v2-v7.7.0) (2025-02-12)


### Features

* Update default EKS cluster version to 1.30 ([#10686](https://github.com/chanzuckerberg/shared-infra/issues/10686)) ([f172d2e](https://github.com/chanzuckerberg/shared-infra/commit/f172d2e2bad117e56c376e786312942ab5818749))

## [7.6.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.6.0...eks-cluster-v2-v7.6.1) (2025-02-10)


### BugFixes

* default route53 zone arns to match blueprint defaults ([#10581](https://github.com/chanzuckerberg/shared-infra/issues/10581)) ([4a982d6](https://github.com/chanzuckerberg/shared-infra/commit/4a982d644f0bb7859134a3df85db935214553c0f))
* Speed up karpenter node consolidation (consolidate after 1 minute) ([#10676](https://github.com/chanzuckerberg/shared-infra/issues/10676)) ([c5e84a5](https://github.com/chanzuckerberg/shared-infra/commit/c5e84a5228053500e9874e769406a807611dd48f))

## [7.6.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.5.0...eks-cluster-v2-v7.6.0) (2025-01-31)


### Features

* Deploy clustersecretstore into us-east-1 as well (for AI/ML clusters) ([#10654](https://github.com/chanzuckerberg/shared-infra/issues/10654)) ([65452cb](https://github.com/chanzuckerberg/shared-infra/commit/65452cb213e4f5c896e0dd34682499b73de58cc9))

## [7.5.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.4.0...eks-cluster-v2-v7.5.0) (2025-01-16)


### Features

* allow spottospot consolidation ([#10591](https://github.com/chanzuckerberg/shared-infra/issues/10591)) ([5051ebb](https://github.com/chanzuckerberg/shared-infra/commit/5051ebbe0a30b43380ce1b7b147dcc0ac2ae02d0))

## [7.4.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.3.0...eks-cluster-v2-v7.4.0) (2025-01-13)


### Features

* Improve EKS node group updates ([#10559](https://github.com/chanzuckerberg/shared-infra/issues/10559)) ([11ad013](https://github.com/chanzuckerberg/shared-infra/commit/11ad013b5d62196abc89b57361fab3353f45689e))

## [7.3.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.2.2...eks-cluster-v2-v7.3.0) (2024-12-03)


### Features

* allow argus iam role to delete AWS secret ([#10512](https://github.com/chanzuckerberg/shared-infra/issues/10512)) ([d98d84f](https://github.com/chanzuckerberg/shared-infra/commit/d98d84fcc86d57c398a2d87007fa53596dd84c49))

## [7.2.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.2.1...eks-cluster-v2-v7.2.2) (2024-12-03)


### BugFixes

* Disable creation of the usage telemetry cloudformation stack ([#10509](https://github.com/chanzuckerberg/shared-infra/issues/10509)) ([e4eb979](https://github.com/chanzuckerberg/shared-infra/commit/e4eb979c20f29c97f4f2d7f17b1f9b6ec68d78b3))

## [7.2.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.2.0...eks-cluster-v2-v7.2.1) (2024-12-02)


### BugFixes

* enhance the cluster-v2 module to take advantage of oidc configs optionally ([#10502](https://github.com/chanzuckerberg/shared-infra/issues/10502)) ([dbcec36](https://github.com/chanzuckerberg/shared-infra/commit/dbcec362e54790500dbcb714b63426fd0d213021))
* remove spaces from eks identity provider name ([#10503](https://github.com/chanzuckerberg/shared-infra/issues/10503)) ([314f77c](https://github.com/chanzuckerberg/shared-infra/commit/314f77c45cd49a47308121f26750aa1ed4fa027c))

## [7.2.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.1.1...eks-cluster-v2-v7.2.0) (2024-11-26)


### Features

* Fix chart version number for external-dns ([#10493](https://github.com/chanzuckerberg/shared-infra/issues/10493)) ([8265632](https://github.com/chanzuckerberg/shared-infra/commit/8265632bd699a61e08eed0cafa6c415996328016))
* Upgraded external-dns to 0.14.x, provided txtPrefix to the external-dns chart ([#10491](https://github.com/chanzuckerberg/shared-infra/issues/10491)) ([7ae3f28](https://github.com/chanzuckerberg/shared-infra/commit/7ae3f2828f07ab94062be03c887225af7db82dfc))


### BugFixes

* Revert external-dns chart version to 0.13.0 ([#10490](https://github.com/chanzuckerberg/shared-infra/issues/10490)) ([cc022d1](https://github.com/chanzuckerberg/shared-infra/commit/cc022d17abe1ef8b9b877aabdf868d22239ebc54))

## [7.1.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.1.0...eks-cluster-v2-v7.1.1) (2024-11-26)


### BugFixes

* Explicitly specify txtPrefix to bypass external-dns issue ([#10487](https://github.com/chanzuckerberg/shared-infra/issues/10487)) ([1975e3d](https://github.com/chanzuckerberg/shared-infra/commit/1975e3d1eb5dae7bbf5d6b8c4f514144c96474cb))

## [7.1.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.0.2...eks-cluster-v2-v7.1.0) (2024-11-25)


### Features

* AWS Load Balancer Controller Fails, unable to fetch VPC ID ([#10475](https://github.com/chanzuckerberg/shared-infra/issues/10475)) ([545f1ed](https://github.com/chanzuckerberg/shared-infra/commit/545f1eddcca0340db43d47ee8d308a5cb8dfb134))

## [7.0.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.0.1...eks-cluster-v2-v7.0.2) (2024-11-21)


### BugFixes

* Remove ttlSecondsUntilExpired setting from karpenter nodepool ([#10467](https://github.com/chanzuckerberg/shared-infra/issues/10467)) ([9a90f33](https://github.com/chanzuckerberg/shared-infra/commit/9a90f33ed0c216c90e11ac8b337ac7ea62e0980d))

## [7.0.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v7.0.0...eks-cluster-v2-v7.0.1) (2024-11-19)


### BugFixes

* Switch karpenter dns policy to Default to address a critical issue ([#10455](https://github.com/chanzuckerberg/shared-infra/issues/10455)) ([724013d](https://github.com/chanzuckerberg/shared-infra/commit/724013d0fc9097d5283d1b03b646cf81a611e3fd))

## [7.0.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.30.0...eks-cluster-v2-v7.0.0) (2024-11-19)


### ⚠ BREAKING CHANGES

* Upgrade karpentrer to v1.0.8 ([#10446](https://github.com/chanzuckerberg/shared-infra/issues/10446))

### Features

* Upgrade karpentrer to v1.0.8 ([#10446](https://github.com/chanzuckerberg/shared-infra/issues/10446)) ([33614ea](https://github.com/chanzuckerberg/shared-infra/commit/33614eaa0d29332a10c929ee4857c4119724c64f))

## [6.31.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.30.1...eks-cluster-v2-v6.31.0) (2024-10-24)


### Features

* (empty) Triggering release of debezium-jmx-exporter ([#10354](https://github.com/chanzuckerberg/shared-infra/issues/10354)) ([4032074](https://github.com/chanzuckerberg/shared-infra/commit/403207436279015b59e67aa1ac74d4e2136a1848))
* Triggering shared-infra release ([#10362](https://github.com/chanzuckerberg/shared-infra/issues/10362)) ([0edb281](https://github.com/chanzuckerberg/shared-infra/commit/0edb2818a59747dd50d4d30f694f7604ade3be76))

## [6.30.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.30.0...eks-cluster-v2-v6.30.1) (2024-10-11)


### Bug Fixes

* change jupyterhub node selector label ([#10281](https://github.com/chanzuckerberg/shared-infra/issues/10281)) ([a44832b](https://github.com/chanzuckerberg/shared-infra/commit/a44832b9bb1ba6d94b7c16e8b244321f8fcc5251))

## [6.30.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.29.1...eks-cluster-v2-v6.30.0) (2024-10-10)


### Features

* expose certmanager config options to eks cluster module ([#10262](https://github.com/chanzuckerberg/shared-infra/issues/10262)) ([0c730c8](https://github.com/chanzuckerberg/shared-infra/commit/0c730c876ecd9fc467607a07f1d02d8564f162b7))

## [6.29.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.29.0...eks-cluster-v2-v6.29.1) (2024-10-08)


### Bug Fixes

* CDI-3423 - Be more specific for node allocations for jupyterhub ([#10250](https://github.com/chanzuckerberg/shared-infra/issues/10250)) ([4326133](https://github.com/chanzuckerberg/shared-infra/commit/4326133753eaee66da7a93672176a54ed7c46b09))

## [6.29.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.28.0...eks-cluster-v2-v6.29.0) (2024-10-08)


### Features

* CDI-3423 pt1 - Create new jupyterhub 512 profile ([#10246](https://github.com/chanzuckerberg/shared-infra/issues/10246)) ([8032a6f](https://github.com/chanzuckerberg/shared-infra/commit/8032a6f54674e08ff3653a97c65a7820d74e3d6e))

## [6.28.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.27.0...eks-cluster-v2-v6.28.0) (2024-09-30)


### Features

* Fix instance-family restriction on karpneter, preventing it from creating a1.* instances ([#10182](https://github.com/chanzuckerberg/shared-infra/issues/10182)) ([b9a4f81](https://github.com/chanzuckerberg/shared-infra/commit/b9a4f81bfc53ec100f1600c5416fd72affd47112))

## [6.27.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.26.0...eks-cluster-v2-v6.27.0) (2024-09-25)


### Features

* karpenter - do not schedule a1 instances due to ebs driver incompatibility ([#10167](https://github.com/chanzuckerberg/shared-infra/issues/10167)) ([27bad61](https://github.com/chanzuckerberg/shared-infra/commit/27bad61538941e6999fa4fe74d12606183d8857d))

## [6.26.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.25.1...eks-cluster-v2-v6.26.0) (2024-09-10)


### Features

* Increase initialDelaySeconds for jupyterhub ([#10119](https://github.com/chanzuckerberg/shared-infra/issues/10119)) ([9983843](https://github.com/chanzuckerberg/shared-infra/commit/9983843a9a2fb3ed89d6eeee5b5aad7db52b00d2))


### Bug Fixes

* Move to hub section ([#10121](https://github.com/chanzuckerberg/shared-infra/issues/10121)) ([20af622](https://github.com/chanzuckerberg/shared-infra/commit/20af6222aa88cfa7a2e5b3261e65d60f805bc141))

## [6.25.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.25.0...eks-cluster-v2-v6.25.1) (2024-09-09)


### Bug Fixes

* external secrets cluster secret store us-west-2 ([#10116](https://github.com/chanzuckerberg/shared-infra/issues/10116)) ([6073e58](https://github.com/chanzuckerberg/shared-infra/commit/6073e587e0ab9ddfa87342f8861162e5a5cb752f))

## [6.25.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.24.1...eks-cluster-v2-v6.25.0) (2024-08-29)


### Features

* Optimize karpenter ([#10080](https://github.com/chanzuckerberg/shared-infra/issues/10080)) ([721a13a](https://github.com/chanzuckerberg/shared-infra/commit/721a13a02d41cb061013f6c2d1135834028bbb6e))


### Bug Fixes

* bump timeout and resources on the vpc cni ([#10078](https://github.com/chanzuckerberg/shared-infra/issues/10078)) ([95e5e02](https://github.com/chanzuckerberg/shared-infra/commit/95e5e0240f1fa87b5db14511b7db289ba029b5d7))
* Fix key value ([#10084](https://github.com/chanzuckerberg/shared-infra/issues/10084)) ([2c3d7bc](https://github.com/chanzuckerberg/shared-infra/commit/2c3d7bc79f78657b4d954cc3a8ee289ff07b096c))
* Move karpenter annotation ([#10082](https://github.com/chanzuckerberg/shared-infra/issues/10082)) ([cdb81a7](https://github.com/chanzuckerberg/shared-infra/commit/cdb81a7d08d2fe0cad7e0b6ac386c37b1ff2f593))
* Put extraAnnotations in correct spot ([#10085](https://github.com/chanzuckerberg/shared-infra/issues/10085)) ([9f9d1ab](https://github.com/chanzuckerberg/shared-infra/commit/9f9d1ab93b2fb2fb1bf214da0d17a2d049a1384a))
* Remove metadata ([#10083](https://github.com/chanzuckerberg/shared-infra/issues/10083)) ([557bbf5](https://github.com/chanzuckerberg/shared-infra/commit/557bbf5b35de41695d9fc4ac5d3d889518b3cda2))

## [6.24.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.24.0...eks-cluster-v2-v6.24.1) (2024-08-16)


### Bug Fixes

* duplicate allowed_groups ([#9988](https://github.com/chanzuckerberg/shared-infra/issues/9988)) ([7426ff7](https://github.com/chanzuckerberg/shared-infra/commit/7426ff7f016a7dba19a85685b392f0fdf0a283a8))

## [6.24.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.23.0...eks-cluster-v2-v6.24.0) (2024-08-16)


### Features

* Add instance family to nodepool for jupyterhub ([#9963](https://github.com/chanzuckerberg/shared-infra/issues/9963)) ([4ed64e0](https://github.com/chanzuckerberg/shared-infra/commit/4ed64e03e8e8e7a574008118b2e85cd75e74eae6))
* allow for vpcs to be annotated with multiple clusters ([#9986](https://github.com/chanzuckerberg/shared-infra/issues/9986)) ([3c4d300](https://github.com/chanzuckerberg/shared-infra/commit/3c4d3002e22cac82f467a9705083009880409675))

## [6.23.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.22.0...eks-cluster-v2-v6.23.0) (2024-08-01)


### Features

* Customized server image ([#9919](https://github.com/chanzuckerberg/shared-infra/issues/9919)) ([a07d8a1](https://github.com/chanzuckerberg/shared-infra/commit/a07d8a13534396d57b03da16cd9e5d6891e23802))

## [6.22.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.21.0...eks-cluster-v2-v6.22.0) (2024-07-31)


### Features

* Add new image for jupyterhub kernel ([#9912](https://github.com/chanzuckerberg/shared-infra/issues/9912)) ([36c2e96](https://github.com/chanzuckerberg/shared-infra/commit/36c2e96a3315b16763e62868a57c96a1e4163aad))

## [6.21.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.20.0...eks-cluster-v2-v6.21.0) (2024-07-26)


### Features

* Variablize allowed_groups and admin_groups in jupyterhub chart ([#9876](https://github.com/chanzuckerberg/shared-infra/issues/9876)) ([7d10cd8](https://github.com/chanzuckerberg/shared-infra/commit/7d10cd84b1ba25f98c1b91d9c4ef80cd63cb4e30))

## [6.20.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.19.1...eks-cluster-v2-v6.20.0) (2024-07-24)


### Features

* Add storage class name to var for jupyterhub yaml ([#9857](https://github.com/chanzuckerberg/shared-infra/issues/9857)) ([7af69a5](https://github.com/chanzuckerberg/shared-infra/commit/7af69a5ac0c717219750fd84a7dab3bc1d4dfa26))

## [6.19.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.19.0...eks-cluster-v2-v6.19.1) (2024-07-22)


### Bug Fixes

* Change back to gp3 for storage class name ([#9838](https://github.com/chanzuckerberg/shared-infra/issues/9838)) ([964735e](https://github.com/chanzuckerberg/shared-infra/commit/964735ec4568bea19d7f36b44da6d170b9240d3b))

## [6.19.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.18.2...eks-cluster-v2-v6.19.0) (2024-07-18)


### Features

* Update jupyterhub storageclass to default and update kubeconfig ([#9825](https://github.com/chanzuckerberg/shared-infra/issues/9825)) ([0db54d4](https://github.com/chanzuckerberg/shared-infra/commit/0db54d4b41e9bb187d540212ac64812be51ae4a1))

## [6.18.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.18.1...eks-cluster-v2-v6.18.2) (2024-07-09)


### Bug Fixes

* update the docker image size ([#9764](https://github.com/chanzuckerberg/shared-infra/issues/9764)) ([ab9ddd3](https://github.com/chanzuckerberg/shared-infra/commit/ab9ddd37617a75794257d349b59fd1688e149524))

## [6.18.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.18.0...eks-cluster-v2-v6.18.1) (2024-07-02)


### Bug Fixes

* minimum CPU node size to avoid ENI issue ([#9707](https://github.com/chanzuckerberg/shared-infra/issues/9707)) ([0d004c8](https://github.com/chanzuckerberg/shared-infra/commit/0d004c8451b4a8578e6976fbcae1d556f81bc2e1))

## [6.18.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.17.0...eks-cluster-v2-v6.18.0) (2024-07-01)


### Features

* Upgrade default EKS version to 1.28 in eks-cluster and eks-cluster-v2 ([#9682](https://github.com/chanzuckerberg/shared-infra/issues/9682)) ([4bc04a8](https://github.com/chanzuckerberg/shared-infra/commit/4bc04a855ec502696d34e88352cd9d8a4bc1e905))

## [6.17.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.16.2...eks-cluster-v2-v6.17.0) (2024-06-27)


### Features

* update TFE to create new workspace for route53 ([#9657](https://github.com/chanzuckerberg/shared-infra/issues/9657)) ([fb95df6](https://github.com/chanzuckerberg/shared-infra/commit/fb95df629bc6142aff4d293ab277c8ace0db972f))


### Bug Fixes

* relax default nodepool requirements ([#9671](https://github.com/chanzuckerberg/shared-infra/issues/9671)) ([5e33f4e](https://github.com/chanzuckerberg/shared-infra/commit/5e33f4eb0f00222351f986ba5b8534e4c25fb2e4))

## [6.16.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.16.1...eks-cluster-v2-v6.16.2) (2024-06-06)


### Bug Fixes

* 15 days is not an option ([#9520](https://github.com/chanzuckerberg/shared-infra/issues/9520)) ([899edc8](https://github.com/chanzuckerberg/shared-infra/commit/899edc84f479bf4a1934685d31c51e05165cee62))

## [6.16.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.16.0...eks-cluster-v2-v6.16.1) (2024-06-06)


### Bug Fixes

* log retention to 15 days ([#9513](https://github.com/chanzuckerberg/shared-infra/issues/9513)) ([cb8f52d](https://github.com/chanzuckerberg/shared-infra/commit/cb8f52d77b7c2a9c033dbcc0570891d4b82d7657))

## [6.16.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.15.1...eks-cluster-v2-v6.16.0) (2024-06-04)


### Features

* Disable user signup for cognito and create groups ([#9485](https://github.com/chanzuckerberg/shared-infra/issues/9485)) ([a39e5ee](https://github.com/chanzuckerberg/shared-infra/commit/a39e5ee4244f178ed70c0308e933bf53cfda0a3a))

## [6.15.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.15.0...eks-cluster-v2-v6.15.1) (2024-06-03)


### Bug Fixes

* forgot to attach secrets manager policy to child roles ([#9487](https://github.com/chanzuckerberg/shared-infra/issues/9487)) ([bf733ea](https://github.com/chanzuckerberg/shared-infra/commit/bf733ea1cef09ed8b12ba5304cae664acc4be363))

## [6.15.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.14.1...eks-cluster-v2-v6.15.0) (2024-05-31)


### Features

* Create cognito client ([#9415](https://github.com/chanzuckerberg/shared-infra/issues/9415)) ([2a43baf](https://github.com/chanzuckerberg/shared-infra/commit/2a43bafabcc0231a0e31cae63454087336c0d1db))

## [6.14.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.14.0...eks-cluster-v2-v6.14.1) (2024-05-23)


### Bug Fixes

* needs to be stringlike and not string equals ([#9437](https://github.com/chanzuckerberg/shared-infra/issues/9437)) ([e5b6d24](https://github.com/chanzuckerberg/shared-infra/commit/e5b6d2421780c8e7751c1cd8af31395a0b313c05))

## [6.14.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.13.0...eks-cluster-v2-v6.14.0) (2024-05-20)


### Features

* allow for service accounts to use secretsmanager ([#9416](https://github.com/chanzuckerberg/shared-infra/issues/9416)) ([b140fcc](https://github.com/chanzuckerberg/shared-infra/commit/b140fcc4d82443483323ea35b886016e6ed264b9))

## [6.13.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.12.0...eks-cluster-v2-v6.13.0) (2024-05-17)


### Features

* adding external secrets to eks cluster for argus api ([#9406](https://github.com/chanzuckerberg/shared-infra/issues/9406)) ([73222c0](https://github.com/chanzuckerberg/shared-infra/commit/73222c09a1d374a5a2f759c71e71ee9c4ef8200f))
* Update default cluster version in eks-cluster and eks-cluster-v2 modules to 1.27 ([#9390](https://github.com/chanzuckerberg/shared-infra/issues/9390)) ([53bd260](https://github.com/chanzuckerberg/shared-infra/commit/53bd2603de326e0773d6571e4f95cf248e39b631))
* Upgrade blueprints in eks-cluster-v2 to 1.13.0 ([#9376](https://github.com/chanzuckerberg/shared-infra/issues/9376)) ([dbba1cd](https://github.com/chanzuckerberg/shared-infra/commit/dbba1cd8c3001533c066d93a058d0ded92ca2e64))


### Bug Fixes

* CDI-2980 Add allowed_groups var to jupyterhub yaml ([#9388](https://github.com/chanzuckerberg/shared-infra/issues/9388)) ([8153df2](https://github.com/chanzuckerberg/shared-infra/commit/8153df289b37352b3bb8dcd86344358cd4e65df6))

## [6.12.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.11.1...eks-cluster-v2-v6.12.0) (2024-05-07)


### Features

* create separate log groups for each service ([#9335](https://github.com/chanzuckerberg/shared-infra/issues/9335)) ([7b2bccc](https://github.com/chanzuckerberg/shared-infra/commit/7b2bccc8ada4707b24b8f5bffb8678a987888dd6))

## [6.11.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.11.0...eks-cluster-v2-v6.11.1) (2024-05-06)


### Bug Fixes

* dashes cannot be sids ([#9331](https://github.com/chanzuckerberg/shared-infra/issues/9331)) ([30533d0](https://github.com/chanzuckerberg/shared-infra/commit/30533d0fe6ebd40f08853eedf5efc0ac076ee49d))

## [6.11.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.10.0...eks-cluster-v2-v6.11.0) (2024-05-02)


### Features

* add permissions to the ecr gh action role ([#9329](https://github.com/chanzuckerberg/shared-infra/issues/9329)) ([be7891a](https://github.com/chanzuckerberg/shared-infra/commit/be7891af3e12350801681582f7d0bf919d452a55))

## [6.10.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.9.1...eks-cluster-v2-v6.10.0) (2024-05-01)


### Features

* Add node purpose annotation ([#9284](https://github.com/chanzuckerberg/shared-infra/issues/9284)) ([e219e14](https://github.com/chanzuckerberg/shared-infra/commit/e219e14cb420288d12c83d873e350570d98dad79))
* Ingress for jupyterhub ([#9242](https://github.com/chanzuckerberg/shared-infra/issues/9242)) ([4fcfb62](https://github.com/chanzuckerberg/shared-infra/commit/4fcfb6279fffc6d3b2ace4dbd98ceaa1eaea4d6c))
* Remove node purpose ([#9289](https://github.com/chanzuckerberg/shared-infra/issues/9289)) ([80f8d42](https://github.com/chanzuckerberg/shared-infra/commit/80f8d4200235303529da393204d45ec60e56d79f))


### Bug Fixes

* Change label for nodepool ([#9281](https://github.com/chanzuckerberg/shared-infra/issues/9281)) ([3133954](https://github.com/chanzuckerberg/shared-infra/commit/3133954b3a128d78b739ad76bd02ef64ff45aee1))
* disable kubecost config temporarily ([#9267](https://github.com/chanzuckerberg/shared-infra/issues/9267)) ([7145134](https://github.com/chanzuckerberg/shared-infra/commit/71451349dd3548d8f8bcd960ffdf4ba25a95a8e7))
* Remove node selector ([#9297](https://github.com/chanzuckerberg/shared-infra/issues/9297)) ([0b53842](https://github.com/chanzuckerberg/shared-infra/commit/0b5384259ba017782e6cf552ee47bc307d68e3d5))

## [6.9.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.9.0...eks-cluster-v2-v6.9.1) (2024-04-22)


### Bug Fixes

* typos in module ([#9262](https://github.com/chanzuckerberg/shared-infra/issues/9262)) ([46373ea](https://github.com/chanzuckerberg/shared-infra/commit/46373eaf470d8148fbfe3ee1ae3d3d7354bca9a0))

## [6.9.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.8.0...eks-cluster-v2-v6.9.0) (2024-04-22)


### Features

* Add proxy annotation in helm chart for jupyterhub ([#9232](https://github.com/chanzuckerberg/shared-infra/issues/9232)) ([bee4938](https://github.com/chanzuckerberg/shared-infra/commit/bee49384b3b5d47dc8b486d2823011cf8c594b36))
* jupyterhub addon ([#9196](https://github.com/chanzuckerberg/shared-infra/issues/9196)) ([218a9b3](https://github.com/chanzuckerberg/shared-infra/commit/218a9b363d240b50c35119c0c380126c4608e93f))
* make github action role cluster owner and ecr access ([#9257](https://github.com/chanzuckerberg/shared-infra/issues/9257)) ([bb175ce](https://github.com/chanzuckerberg/shared-infra/commit/bb175ce0f4967ad5d291f31c4d39914768774d52))


### Bug Fixes

* [modules/eks-cluster-v2][playground] kubecost routing fixes ([#9225](https://github.com/chanzuckerberg/shared-infra/issues/9225)) ([a1c9765](https://github.com/chanzuckerberg/shared-infra/commit/a1c9765319a446f2b9f95089a0ef9c77a3b83965))
* Remove deprecated fields from jupyterhub config ([#9230](https://github.com/chanzuckerberg/shared-infra/issues/9230)) ([b405253](https://github.com/chanzuckerberg/shared-infra/commit/b405253d02062af051ca6b57682bb028dd4759f2))
* Remove jupyterhub built-in proxy from helm chart ([#9206](https://github.com/chanzuckerberg/shared-infra/issues/9206)) ([28ecef3](https://github.com/chanzuckerberg/shared-infra/commit/28ecef387ccf2d40ba37d5c075723b331ab65f09))

## [6.8.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.7.0...eks-cluster-v2-v6.8.0) (2024-04-11)


### Features

* Surface EKS kubecost addon config ([#9193](https://github.com/chanzuckerberg/shared-infra/issues/9193)) ([c62d6fb](https://github.com/chanzuckerberg/shared-infra/commit/c62d6fb48e63cb1672464c10631f9c45a936c177))

## [6.7.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.6.0...eks-cluster-v2-v6.7.0) (2024-02-20)


### Features

* Specify karpenter resource requests and limits ([#9043](https://github.com/chanzuckerberg/shared-infra/issues/9043)) ([54bc0fb](https://github.com/chanzuckerberg/shared-infra/commit/54bc0fb5c230904c05d37f8cffeb3e65e40b9991))


### Bug Fixes

* Update karpenter controller resources ([#9044](https://github.com/chanzuckerberg/shared-infra/issues/9044)) ([911defa](https://github.com/chanzuckerberg/shared-infra/commit/911defad3f731a3b827544dc14f030a3a8170ce9))

## [6.6.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.5.1...eks-cluster-v2-v6.6.0) (2024-02-07)


### Features

* allow for user to disable default nodepool ([#9012](https://github.com/chanzuckerberg/shared-infra/issues/9012)) ([d4bfc62](https://github.com/chanzuckerberg/shared-infra/commit/d4bfc6279875e308d830890e111bd1481baafd8f))

## [6.5.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.5.0...eks-cluster-v2-v6.5.1) (2024-02-05)


### Bug Fixes

* Tweak the eks iam role name prefix for backwards compatibility ([#9001](https://github.com/chanzuckerberg/shared-infra/issues/9001)) ([f960431](https://github.com/chanzuckerberg/shared-infra/commit/f960431c6447e46e39b406829cb0e41892dd911a))

## [6.5.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.4.2...eks-cluster-v2-v6.5.0) (2024-01-30)


### Features

* Upgrade eks default cluster version to 1.26 ([#8983](https://github.com/chanzuckerberg/shared-infra/issues/8983)) ([6691e22](https://github.com/chanzuckerberg/shared-infra/commit/6691e226b3501ebd150951ba91356a18119469df))

## [6.4.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.4.1...eks-cluster-v2-v6.4.2) (2024-01-16)


### Bug Fixes

* Reverse the iam name prefix calculation logic ([#8922](https://github.com/chanzuckerberg/shared-infra/issues/8922)) ([230da7a](https://github.com/chanzuckerberg/shared-infra/commit/230da7a354ee992ea6909a0940d5cd3e505d5dd2))

## [6.4.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.4.0...eks-cluster-v2-v6.4.1) (2024-01-16)


### Bug Fixes

* Add support for iam_cluster_name_prefix ([#8921](https://github.com/chanzuckerberg/shared-infra/issues/8921)) ([a2fe433](https://github.com/chanzuckerberg/shared-infra/commit/a2fe433821221f1a926398db3a8969962a873eb3))

## [6.4.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.3.0...eks-cluster-v2-v6.4.0) (2024-01-10)


### Features

* Upgrade karpenter to the beta release ([#8862](https://github.com/chanzuckerberg/shared-infra/issues/8862)) ([851e4ed](https://github.com/chanzuckerberg/shared-infra/commit/851e4ed03e300d1b81c003ecf615dfe999d6eba4))
* Upgrade karpenter to v0.33.0 in playground ([#8868](https://github.com/chanzuckerberg/shared-infra/issues/8868)) ([d33f66e](https://github.com/chanzuckerberg/shared-infra/commit/d33f66e0409b7e2e58715a5a95c785ab76823229))

## [6.3.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.2.0...eks-cluster-v2-v6.3.0) (2023-12-12)


### Features

* Add the ability to provide argocd helm settings ([#8827](https://github.com/chanzuckerberg/shared-infra/issues/8827)) ([0371f1a](https://github.com/chanzuckerberg/shared-infra/commit/0371f1acf974af3b137099ec2cfd1f8a0b463101))

## [6.2.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.1.1...eks-cluster-v2-v6.2.0) (2023-11-28)


### Features

* Read only and owner role mapping ([#8784](https://github.com/chanzuckerberg/shared-infra/issues/8784)) ([dcb43c0](https://github.com/chanzuckerberg/shared-infra/commit/dcb43c0cbbfc109c9a5f2078e2589835349b1149))

## [6.1.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.1.0...eks-cluster-v2-v6.1.1) (2023-11-22)


### Bug Fixes

* max_size can't be set to zero ([#8749](https://github.com/chanzuckerberg/shared-infra/issues/8749)) ([18ff86f](https://github.com/chanzuckerberg/shared-infra/commit/18ff86fd81f9598c9dd7094d7f7f22cb43a8fc3e))
* Remove redundant fluentbit log config ([#8772](https://github.com/chanzuckerberg/shared-infra/issues/8772)) ([55ed8dd](https://github.com/chanzuckerberg/shared-infra/commit/55ed8dd09c9efa8719bc59a2c73a4bd3210fbe6b))

## [6.1.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v6.0.0...eks-cluster-v2-v6.1.0) (2023-11-03)


### Features

* allow users to add trusted aws accounts ([#8704](https://github.com/chanzuckerberg/shared-infra/issues/8704)) ([1075f6f](https://github.com/chanzuckerberg/shared-infra/commit/1075f6f12c815c909486902cd09111a2b31a35f8))

## [6.0.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.4.0...eks-cluster-v2-v6.0.0) (2023-11-03)


### ⚠ BREAKING CHANGES

* refactor how node groups work with sizing (#8733)

### Bug Fixes

* refactor how node groups work with sizing ([#8733](https://github.com/chanzuckerberg/shared-infra/issues/8733)) ([b70bad7](https://github.com/chanzuckerberg/shared-infra/commit/b70bad76f2d2fc2b97a348afc511cc0adad99441))

## [5.4.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.3.1...eks-cluster-v2-v5.4.0) (2023-10-31)


### Features

* Re-create czi-sci-gen-east-dev-eks ([#8702](https://github.com/chanzuckerberg/shared-infra/issues/8702)) ([d1fb17d](https://github.com/chanzuckerberg/shared-infra/commit/d1fb17d880d0c02e202b1db208c91203c39b8322))

## [5.3.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.3.0...eks-cluster-v2-v5.3.1) (2023-10-30)


### Bug Fixes

* External-dns ignores the exclude annotation (record owner is not populated) ([#8700](https://github.com/chanzuckerberg/shared-infra/issues/8700)) ([abc85cc](https://github.com/chanzuckerberg/shared-infra/commit/abc85cc22c163c7eaeba7ce29b0c0e24dc8d9736))

## [5.3.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.2.5...eks-cluster-v2-v5.3.0) (2023-10-27)


### Features

* Enable karpenter drift detection and upgrade blueprints ([#8696](https://github.com/chanzuckerberg/shared-infra/issues/8696)) ([aac2b9d](https://github.com/chanzuckerberg/shared-infra/commit/aac2b9d2fbcb9c8a7d8549cdf04dffab44402a20))


### Bug Fixes

* Fix lengthy karpenter iam role name prefix ([#8697](https://github.com/chanzuckerberg/shared-infra/issues/8697)) ([aaf0d78](https://github.com/chanzuckerberg/shared-infra/commit/aaf0d783b37b583a833b233eb53534d57e4b8e8b))

## [5.2.5](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.2.4...eks-cluster-v2-v5.2.5) (2023-10-24)


### Bug Fixes

* Filter out otel collector logs redux ([#8656](https://github.com/chanzuckerberg/shared-infra/issues/8656)) ([ef65f57](https://github.com/chanzuckerberg/shared-infra/commit/ef65f57d87c7120816f701a0773c2008406b7996))

## [5.2.4](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.2.3...eks-cluster-v2-v5.2.4) (2023-10-23)


### Bug Fixes

* filter otc-container logs ([#8651](https://github.com/chanzuckerberg/shared-infra/issues/8651)) ([84b8928](https://github.com/chanzuckerberg/shared-infra/commit/84b892888259207f7b7b2b181867d87b5b681675))

## [5.2.3](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.2.2...eks-cluster-v2-v5.2.3) (2023-10-17)


### Bug Fixes

* Fluentbit for AWS Configuration ([#8530](https://github.com/chanzuckerberg/shared-infra/issues/8530)) ([54d0859](https://github.com/chanzuckerberg/shared-infra/commit/54d0859498f139b402b62ab82392b3bb5f67e47a))

## [5.2.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.2.1...eks-cluster-v2-v5.2.2) (2023-10-04)


### Bug Fixes

* don't use a name prefix ([#8512](https://github.com/chanzuckerberg/shared-infra/issues/8512)) ([f122a78](https://github.com/chanzuckerberg/shared-infra/commit/f122a782f08e6cf748bfe092240369298c029ba3))
* terraform typo ([#8513](https://github.com/chanzuckerberg/shared-infra/issues/8513)) ([e14c72d](https://github.com/chanzuckerberg/shared-infra/commit/e14c72d5672e94f8d624eb1a7099046d9b64e471))

## [5.2.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.2.0...eks-cluster-v2-v5.2.1) (2023-10-04)


### Bug Fixes

* Prevent external dns from endlessly restarting ([#8508](https://github.com/chanzuckerberg/shared-infra/issues/8508)) ([c70e62a](https://github.com/chanzuckerberg/shared-infra/commit/c70e62ae637039f2cc89e9e618acbbf1dc93a6bf))
* Prevent external dns from endlessly restarting ([#8509](https://github.com/chanzuckerberg/shared-infra/issues/8509)) ([4b44b64](https://github.com/chanzuckerberg/shared-infra/commit/4b44b647188798b87255170682f40ff142446d81))

## [5.2.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.1.0...eks-cluster-v2-v5.2.0) (2023-10-03)


### Features

* Move Karpenter to a fargate profile and exclude nodelocaldns, rancher monitoring and datadog agent from running on fargate ([#8495](https://github.com/chanzuckerberg/shared-infra/issues/8495)) ([49a06ec](https://github.com/chanzuckerberg/shared-infra/commit/49a06ec2239445468879ae7a343ef9c70834b0ab))

## [5.1.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.0.1...eks-cluster-v2-v5.1.0) (2023-10-03)


### Features

* Dynamically figure out EKS ami_release_version ([#8494](https://github.com/chanzuckerberg/shared-infra/issues/8494)) ([d5a90b1](https://github.com/chanzuckerberg/shared-infra/commit/d5a90b1c6ae3cd2f2a9f74e58f554b2bf275e612))

## [5.0.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v5.0.0...eks-cluster-v2-v5.0.1) (2023-10-02)


### Bug Fixes

* allow alb controller to see secrets ([#8479](https://github.com/chanzuckerberg/shared-infra/issues/8479)) ([1efe8c9](https://github.com/chanzuckerberg/shared-infra/commit/1efe8c9ca55cabc8f9016420a1268371c3b3cbc2))
* Fix Linkerd on Karpenter nodes ([#8491](https://github.com/chanzuckerberg/shared-infra/issues/8491)) ([43f015f](https://github.com/chanzuckerberg/shared-infra/commit/43f015f3210f8f3a57bf1a6bf84733e7f4bc092f))

## [5.0.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.7.0...eks-cluster-v2-v5.0.0) (2023-09-18)


### ⚠ BREAKING CHANGES

* Move core responsibilities of k8s-core into eks-cluster and eks-cluster-v2 (#8384)

### Features

* Move core responsibilities of k8s-core into eks-cluster and eks-cluster-v2 ([#8384](https://github.com/chanzuckerberg/shared-infra/issues/8384)) ([d173abf](https://github.com/chanzuckerberg/shared-infra/commit/d173abf516b61df8e8b013252557c6dec8f7ac0e))
* Upgrade cluster module and allow taints and labels to be passed to nodegroups ([#8407](https://github.com/chanzuckerberg/shared-infra/issues/8407)) ([a79a37f](https://github.com/chanzuckerberg/shared-infra/commit/a79a37fa42ae2d9f52a473972df605e83ccd550b))


### Bug Fixes

* Fix playground taints ([#8408](https://github.com/chanzuckerberg/shared-infra/issues/8408)) ([b58af9f](https://github.com/chanzuckerberg/shared-infra/commit/b58af9f0569907a9b15a4ca1771ee8f5010c0bcf))

## [4.7.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.6.2...eks-cluster-v2-v4.7.0) (2023-08-25)


### Features

* Upgrade eks-v2 ami releases to v20230816 ([#8327](https://github.com/chanzuckerberg/shared-infra/issues/8327)) ([011ebb1](https://github.com/chanzuckerberg/shared-infra/commit/011ebb1b94ab5485c096236630aada3632408bca))

## [4.6.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.6.1...eks-cluster-v2-v4.6.2) (2023-08-21)


### Bug Fixes

* limit guardduty security group names to 63 characters ([#8319](https://github.com/chanzuckerberg/shared-infra/issues/8319)) ([81a16cc](https://github.com/chanzuckerberg/shared-infra/commit/81a16cc9794daba1dd384a3c57949a7f986bae71))
* security group naming for guardduty ([#8318](https://github.com/chanzuckerberg/shared-infra/issues/8318)) ([c455d74](https://github.com/chanzuckerberg/shared-infra/commit/c455d7461cf3cd48e6bd6a91a6470b6c57c391db))

## [4.6.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.6.0...eks-cluster-v2-v4.6.1) (2023-07-28)


### Bug Fixes

* outputs for eks-cluster-v2 module. ([#8126](https://github.com/chanzuckerberg/shared-infra/issues/8126)) ([a33c381](https://github.com/chanzuckerberg/shared-infra/commit/a33c381c32b9a0ba07c20e4d4c7f568036d05dcb))
* security group rules in eks-cluster-v2 module ([#8125](https://github.com/chanzuckerberg/shared-infra/issues/8125)) ([fe35cb2](https://github.com/chanzuckerberg/shared-infra/commit/fe35cb2168a308376be9f38cf809395a87253b33))

## [4.6.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.5.2...eks-cluster-v2-v4.6.0) (2023-06-21)


### Features

* Enable guardduty agents ([#7963](https://github.com/chanzuckerberg/shared-infra/issues/7963)) ([1b817b9](https://github.com/chanzuckerberg/shared-infra/commit/1b817b93a8ba7d0d71bb763c63ef5762601aeec9))

## [4.5.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.5.1...eks-cluster-v2-v4.5.2) (2023-05-30)


### Bug Fixes

* Avoid eks node policies flip-flopping ([#7881](https://github.com/chanzuckerberg/shared-infra/issues/7881)) ([f9a7830](https://github.com/chanzuckerberg/shared-infra/commit/f9a7830216cacdb81a5b427496fff232fc1dbb16))

## [4.5.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.5.0...eks-cluster-v2-v4.5.1) (2023-05-26)


### Bug Fixes

* tack on the SSM Policy for easier Auditability (security) ([#7874](https://github.com/chanzuckerberg/shared-infra/issues/7874)) ([494abae](https://github.com/chanzuckerberg/shared-infra/commit/494abae29c9c8a37b7df7d9bc4d3043959f22b6d))

## [4.5.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.4.0...eks-cluster-v2-v4.5.0) (2023-05-25)


### Features

* Support for EKS 1.27 ([#7869](https://github.com/chanzuckerberg/shared-infra/issues/7869)) ([000a6fb](https://github.com/chanzuckerberg/shared-infra/commit/000a6fb8c0c1964ae58a8149ff0d45ae8ba0e51c))


### Bug Fixes

* Cleanup eks-cluster-v2 ([#7866](https://github.com/chanzuckerberg/shared-infra/issues/7866)) ([e47c382](https://github.com/chanzuckerberg/shared-infra/commit/e47c38224d17b2233b9f37fce88470757be60cdb))

## [4.4.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.3.0...eks-cluster-v2-v4.4.0) (2023-05-23)


### Features

* Add number of partitions to EKS placement groups to match number of subnets ([#7850](https://github.com/chanzuckerberg/shared-infra/issues/7850)) ([952e75b](https://github.com/chanzuckerberg/shared-infra/commit/952e75b8a4b190aaa45e580a2903700942351b1f))

## [4.3.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.2.0...eks-cluster-v2-v4.3.0) (2023-05-23)


### Features

* change default for ami release version ([#7818](https://github.com/chanzuckerberg/shared-infra/issues/7818)) ([e2a9d5f](https://github.com/chanzuckerberg/shared-infra/commit/e2a9d5fbc0707ae98b691812c716939e9c470fb0))
* Support placement groups (CCIE-1475) ([#7846](https://github.com/chanzuckerberg/shared-infra/issues/7846)) ([4372b8b](https://github.com/chanzuckerberg/shared-infra/commit/4372b8b7ba17210a25a7cf0126437cb468d7b3e4))

## [4.2.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.1.0...eks-cluster-v2-v4.2.0) (2023-05-04)


### Features

* refactor tfe-agent to allow custom image ([#7758](https://github.com/chanzuckerberg/shared-infra/issues/7758)) ([ef5a88e](https://github.com/chanzuckerberg/shared-infra/commit/ef5a88ebb5d2b571e39208ce908d09a03c1f1a86))

## [4.1.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v4.0.0...eks-cluster-v2-v4.1.0) (2023-05-02)


### Features

* allow eks cluster to make gh CI roles ([#7746](https://github.com/chanzuckerberg/shared-infra/issues/7746)) ([46c62b2](https://github.com/chanzuckerberg/shared-infra/commit/46c62b200208f3d4d008f9165302552043591b36))

## [4.0.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v3.2.0...eks-cluster-v2-v4.0.0) (2023-04-28)


### ⚠ BREAKING CHANGES

* k8s-core major version bump (#7726)

### Features

* k8s-core major version bump ([#7726](https://github.com/chanzuckerberg/shared-infra/issues/7726)) ([1c44772](https://github.com/chanzuckerberg/shared-infra/commit/1c4477285cf5a26411a73396bb631eea39a67e6b))

## [3.2.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v3.1.0...eks-cluster-v2-v3.2.0) (2023-04-20)


### Features

* Support for EKS 1.26 ([#7676](https://github.com/chanzuckerberg/shared-infra/issues/7676)) ([bdc301a](https://github.com/chanzuckerberg/shared-infra/commit/bdc301a938735bef506d262e68a9b3ddc77aa646))

## [3.1.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v3.0.1...eks-cluster-v2-v3.1.0) (2023-03-31)


### Features

* Upgrade eks v2 amis ([#7566](https://github.com/chanzuckerberg/shared-infra/issues/7566)) ([98c9cde](https://github.com/chanzuckerberg/shared-infra/commit/98c9cde047935dc79996e2c01c579e14c23acefd))

## [3.0.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v3.0.0...eks-cluster-v2-v3.0.1) (2023-03-28)


### Bug Fixes

* Reference the ami_type argument ([#7549](https://github.com/chanzuckerberg/shared-infra/issues/7549)) ([fb450a6](https://github.com/chanzuckerberg/shared-infra/commit/fb450a6f6ca3ac8dac5f32f2a79ba105b8b68058))

## [3.0.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v2.1.0...eks-cluster-v2-v3.0.0) (2023-03-27)


### ⚠ BREAKING CHANGES

* breaking change to eks-cluster-v2 variables (#7540)

### Bug Fixes

* breaking change to eks-cluster-v2 variables ([#7540](https://github.com/chanzuckerberg/shared-infra/issues/7540)) ([f863150](https://github.com/chanzuckerberg/shared-infra/commit/f863150a75e53595ab93b5e1e18c51c12242b85e))

## [2.1.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v2.0.0...eks-cluster-v2-v2.1.0) (2023-03-27)


### Features

* Upgrade playground EKS to 1.25 ([#7526](https://github.com/chanzuckerberg/shared-infra/issues/7526)) ([b720cf6](https://github.com/chanzuckerberg/shared-infra/commit/b720cf6e1c0b9d6b28fdfa1c76934a98ccd6477f))

## [2.0.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.11.0...eks-cluster-v2-v2.0.0) (2023-03-23)


### ⚠ BREAKING CHANGES

* refactor eks-cluster-v2 module to be clean (#7511)

### Features

* refactor eks-cluster-v2 module to be clean ([#7511](https://github.com/chanzuckerberg/shared-infra/issues/7511)) ([ba31b14](https://github.com/chanzuckerberg/shared-infra/commit/ba31b147ae67d7cdc2b0ca05332192e628027eae))

## [1.11.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.10.1...eks-cluster-v2-v1.11.0) (2023-03-17)


### Features

* Prep work for EKS 1.25 upgrade (updated ami releases, added addon version discovery) ([#7479](https://github.com/chanzuckerberg/shared-infra/issues/7479)) ([ee1de12](https://github.com/chanzuckerberg/shared-infra/commit/ee1de1284d1bd918d0f80ea6dc3e8aeed5c7da4e))

## [1.10.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.10.0...eks-cluster-v2-v1.10.1) (2023-03-15)


### Bug Fixes

* Remove eks v2 module circular dependency ([#7455](https://github.com/chanzuckerberg/shared-infra/issues/7455)) ([3431bff](https://github.com/chanzuckerberg/shared-infra/commit/3431bff710a3da0c4036e06c4c32f904d5b41d8b))

## [1.10.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.9.0...eks-cluster-v2-v1.10.0) (2023-03-14)


### Features

* ARM support at the EKS cluster level (eks-cluster-v2) ([#7450](https://github.com/chanzuckerberg/shared-infra/issues/7450)) ([b2a1cce](https://github.com/chanzuckerberg/shared-infra/commit/b2a1cce2cac2c6ab54ef1c8bebd7321dffff9c59))

## [1.9.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.8.1...eks-cluster-v2-v1.9.0) (2023-03-10)


### Features

* Upgrade eks-cluster-v2 to use terraform-aws-modules/eks/aws 19.x ([#7386](https://github.com/chanzuckerberg/shared-infra/issues/7386)) ([2c39cb9](https://github.com/chanzuckerberg/shared-infra/commit/2c39cb98b4b08add2c5503e94ae928ba83092fb6))

## [1.8.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.8.0...eks-cluster-v2-v1.8.1) (2023-02-24)


### Bug Fixes

* remove use of system node groups ([#7312](https://github.com/chanzuckerberg/shared-infra/issues/7312)) ([b57491b](https://github.com/chanzuckerberg/shared-infra/commit/b57491b63f01a0a753808d11421f3f56d6392e90))

## [1.8.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.7.0...eks-cluster-v2-v1.8.0) (2023-02-17)


### Features

* remove system nodes by default ([#7242](https://github.com/chanzuckerberg/shared-infra/issues/7242)) ([ef1b25d](https://github.com/chanzuckerberg/shared-infra/commit/ef1b25d4a048d75c2a3f99e753970029fe687125))

## [1.7.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.6.1...eks-cluster-v2-v1.7.0) (2023-02-09)


### Features

* Update EKS AMIs ([#7195](https://github.com/chanzuckerberg/shared-infra/issues/7195)) ([42c127b](https://github.com/chanzuckerberg/shared-infra/commit/42c127b033da7c17045fc5b1505533c67d0a9c3b))

## [1.6.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.6.0...eks-cluster-v2-v1.6.1) (2022-11-30)


### Bug Fixes

* Upgrade EKS EBS add-on version to v1.13.0-eksbuild.2 ([#6805](https://github.com/chanzuckerberg/shared-infra/issues/6805)) ([c1dbcea](https://github.com/chanzuckerberg/shared-infra/commit/c1dbceae1c7d18875309a37ba92f1b506888a4b9))

## [1.6.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.5.0...eks-cluster-v2-v1.6.0) (2022-11-23)


### Features

* add 1.24 to k8s-core version ([#6783](https://github.com/chanzuckerberg/shared-infra/issues/6783)) ([a497dad](https://github.com/chanzuckerberg/shared-infra/commit/a497dad20286f5524a537df77cdb39eeaab4f8dd))


### Bug Fixes

* output kubeconfig ([#6782](https://github.com/chanzuckerberg/shared-infra/issues/6782)) ([fcc705d](https://github.com/chanzuckerberg/shared-infra/commit/fcc705d3e64f0f5160f3690dabe7b8a63fb24353))

## [1.5.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.4.2...eks-cluster-v2-v1.5.0) (2022-11-17)


### Features

* Upgrade playground EKS to 1.24 ([#6730](https://github.com/chanzuckerberg/shared-infra/issues/6730)) ([805180d](https://github.com/chanzuckerberg/shared-infra/commit/805180d6c11d572bd97a61c4b2579e00c943b7e3))

## [1.4.2](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.4.1...eks-cluster-v2-v1.4.2) (2022-10-11)


### Bug Fixes

* Update EKS addon versions for eks-cluster-v2 ([#6479](https://github.com/chanzuckerberg/shared-infra/issues/6479)) ([5f85b59](https://github.com/chanzuckerberg/shared-infra/commit/5f85b59c261f1dbdd6af72d69ae099be821658de))

## [1.4.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.4.0...eks-cluster-v2-v1.4.1) (2022-09-27)


### Bug Fixes

* Specify the max unavailable node percentage for EKS managed node groups ([#6274](https://github.com/chanzuckerberg/shared-infra/issues/6274)) ([0a272c7](https://github.com/chanzuckerberg/shared-infra/commit/0a272c7734e6cc809096f5832db5bc9580eae60a))

## [1.4.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.3.1...eks-cluster-v2-v1.4.0) (2022-09-12)


### Features

* Support for EKS 1.23 ([#6236](https://github.com/chanzuckerberg/shared-infra/issues/6236)) ([31dc9df](https://github.com/chanzuckerberg/shared-infra/commit/31dc9df87a6fbc3445b465facef027422e43db5d))
* Upgrade eks-cluster-v2 module to use underlying eks 18.29.0 module ([#6234](https://github.com/chanzuckerberg/shared-infra/issues/6234)) ([efbe1c2](https://github.com/chanzuckerberg/shared-infra/commit/efbe1c23a434f09632ef60bf5baa03156745b672))

## [1.3.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.3.0...eks-cluster-v2-v1.3.1) (2022-09-01)


### Bug Fixes

* namespacing in tfe-agents ([#6157](https://github.com/chanzuckerberg/shared-infra/issues/6157)) ([7e59401](https://github.com/chanzuckerberg/shared-infra/commit/7e59401116599fa04a5503d151e13128dabee025))

## [1.3.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.2.1...eks-cluster-v2-v1.3.0) (2022-08-25)


### Features

* Update AMI versions for EKSv2 and re-attach the role to vpc-cni… ([#6084](https://github.com/chanzuckerberg/shared-infra/issues/6084)) ([68eee74](https://github.com/chanzuckerberg/shared-infra/commit/68eee740dc97a934788cd91fe1b7d6f02c3d935e))


### Bug Fixes

* VPC CNI and EBS roles in EKS modules had incorrect conditions ([#6083](https://github.com/chanzuckerberg/shared-infra/issues/6083)) ([8e1b809](https://github.com/chanzuckerberg/shared-infra/commit/8e1b8091d503548c145194d94c95c25adb79954f))

## [1.2.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.2.0...eks-cluster-v2-v1.2.1) (2022-08-19)


### Bug Fixes

* A role ARN was incorrectly returned instead of a role name ([#6028](https://github.com/chanzuckerberg/shared-infra/issues/6028)) ([16efdc2](https://github.com/chanzuckerberg/shared-infra/commit/16efdc23602bff85db5bff01460dbebde749dec6))

## [1.2.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.1.1...eks-cluster-v2-v1.2.0) (2022-08-15)


### Features

* **CCIE-512:** Modify EKS addons to support EBS CSI Driver ([#5974](https://github.com/chanzuckerberg/shared-infra/issues/5974)) ([8ac9b13](https://github.com/chanzuckerberg/shared-infra/commit/8ac9b131a1ced3065711bd9a431810221e3eabac))

## [1.1.1](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.1.0...eks-cluster-v2-v1.1.1) (2022-08-09)


### Bug Fixes

* add databricks to dev-cutter providers ([#5900](https://github.com/chanzuckerberg/shared-infra/issues/5900)) ([fe7d0cc](https://github.com/chanzuckerberg/shared-infra/commit/fe7d0ccea6a694728e7d7aab4a35a08f630d02d9))

## [1.1.0](https://github.com/chanzuckerberg/shared-infra/compare/eks-cluster-v2-v1.0.0...eks-cluster-v2-v1.1.0) (2022-08-05)


### Features

* Add capacity to system node group ([#5843](https://github.com/chanzuckerberg/shared-infra/issues/5843)) ([2d718fe](https://github.com/chanzuckerberg/shared-infra/commit/2d718feb3c08d2c80890c8fb4a1a5ae2a22d3370))
* Add fargate profile to EKS v2 ([#5835](https://github.com/chanzuckerberg/shared-infra/issues/5835)) ([73326a9](https://github.com/chanzuckerberg/shared-infra/commit/73326a97d1a1281720083a6d1c1d472cba32675b))
* Slight reduction in EKS v2 node size ([#5848](https://github.com/chanzuckerberg/shared-infra/issues/5848)) ([74cd0f0](https://github.com/chanzuckerberg/shared-infra/commit/74cd0f05631b36991d892e0622927619f6b3ad60))
* Upgrade AMI release version for EKS 1.22 ([#5846](https://github.com/chanzuckerberg/shared-infra/issues/5846)) ([62ffc80](https://github.com/chanzuckerberg/shared-infra/commit/62ffc800817d43285e8a862ac1de5dd84d7ded82))
* Upgrade EKS module to 18.26.3 ([#5308](https://github.com/chanzuckerberg/shared-infra/issues/5308)) ([caa068f](https://github.com/chanzuckerberg/shared-infra/commit/caa068fb505271dea80bc8cc42fb7e17b661a724))


### Bug Fixes

* Add eks-cluster-v2 to package list ([#5830](https://github.com/chanzuckerberg/shared-infra/issues/5830)) ([c87fa79](https://github.com/chanzuckerberg/shared-infra/commit/c87fa79ea4a17d096448ad76061ff2fc45a793c4))
* Add more ephemeral storage for EKSv2 ([#5826](https://github.com/chanzuckerberg/shared-infra/issues/5826)) ([522fca5](https://github.com/chanzuckerberg/shared-infra/commit/522fca5141bfd6fd08e968215d62bfda28fed029))
* Fix autoscaling in EKS v2 ([#5805](https://github.com/chanzuckerberg/shared-infra/issues/5805)) ([df11ce1](https://github.com/chanzuckerberg/shared-infra/commit/df11ce180fe7bf3a450370e3c4043a4a4ecf3e68))
* Upgrade cluster autoscaler for EKS 1.22 ([#5814](https://github.com/chanzuckerberg/shared-infra/issues/5814)) ([544afc3](https://github.com/chanzuckerberg/shared-infra/commit/544afc3155e2ada5aaa46607ca75203cbd813afe))
