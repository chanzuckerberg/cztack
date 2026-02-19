# Changelog

## [4.7.0](https://github.com/chanzuckerberg/cztack/compare/aws-vpc-env-v4.6.0...aws-vpc-env-v4.7.0) (2026-02-12)


### Features

* add aws-vpc-env module for VPC provisioning ([#818](https://github.com/chanzuckerberg/cztack/issues/818)) ([d5c8d3c](https://github.com/chanzuckerberg/cztack/commit/d5c8d3cbfe224c510c7123e23ba7740773e467ce))

## [4.6.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v4.5.0...aws-env-v4.6.0) (2025-09-25)


### Features

* Support cross-region vpc endpoints ([#11452](https://github.com/chanzuckerberg/shared-infra/issues/11452)) ([253b09e](https://github.com/chanzuckerberg/shared-infra/commit/253b09e94eb2b726932b2572920516eb761f9e50))

## [4.5.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v4.4.0...aws-env-v4.5.0) (2025-09-23)


### Features

* Support for Loki private endpoint creation ([#11440](https://github.com/chanzuckerberg/shared-infra/issues/11440)) ([9e2fa55](https://github.com/chanzuckerberg/shared-infra/commit/9e2fa553bf2c8117a4913354ee0281e86fb548e2))

## [4.4.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v4.3.0...aws-env-v4.4.0) (2025-02-18)


### Features

* Trigger aws-env release to fix machine-images in bastions ([#10718](https://github.com/chanzuckerberg/shared-infra/issues/10718)) ([69849d1](https://github.com/chanzuckerberg/shared-infra/commit/69849d14993461bfdfccb5b7acfaa3c4ff6e6267))

## [4.3.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v4.2.0...aws-env-v4.3.0) (2025-02-13)


### Features

* Trigger the release of aws-env to pickup latest machine-images ([#10697](https://github.com/chanzuckerberg/shared-infra/issues/10697)) ([751f52f](https://github.com/chanzuckerberg/shared-infra/commit/751f52f3a5cd5da3f1f61a4230b30a66156536f4))

## [4.3.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v4.2.0...aws-env-v4.3.0) (2024-10-24)


### Features

* (empty) Triggering release of debezium-jmx-exporter ([#10354](https://github.com/chanzuckerberg/shared-infra/issues/10354)) ([4032074](https://github.com/chanzuckerberg/shared-infra/commit/403207436279015b59e67aa1ac74d4e2136a1848))
* Triggering shared-infra release ([#10362](https://github.com/chanzuckerberg/shared-infra/issues/10362)) ([0edb281](https://github.com/chanzuckerberg/shared-infra/commit/0edb2818a59747dd50d4d30f694f7604ade3be76))

## [4.2.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v4.1.0...aws-env-v4.2.0) (2024-08-16)


### Features

* allow for vpcs to be annotated with multiple clusters ([#9986](https://github.com/chanzuckerberg/shared-infra/issues/9986)) ([3c4d300](https://github.com/chanzuckerberg/shared-infra/commit/3c4d3002e22cac82f467a9705083009880409675))

## [4.1.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v4.0.0...aws-env-v4.1.0) (2024-06-27)


### Features

* update TFE to create new workspace for route53 ([#9657](https://github.com/chanzuckerberg/shared-infra/issues/9657)) ([fb95df6](https://github.com/chanzuckerberg/shared-infra/commit/fb95df629bc6142aff4d293ab277c8ace0db972f))

## [4.0.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.5.5...aws-env-v4.0.0) (2023-09-18)


### ⚠ BREAKING CHANGES

* Move core responsibilities of k8s-core into eks-cluster and eks-cluster-v2 (#8384)

### Features

* Move core responsibilities of k8s-core into eks-cluster and eks-cluster-v2 ([#8384](https://github.com/chanzuckerberg/shared-infra/issues/8384)) ([d173abf](https://github.com/chanzuckerberg/shared-infra/commit/d173abf516b61df8e8b013252557c6dec8f7ac0e))

## [3.5.5](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.5.4...aws-env-v3.5.5) (2023-08-16)


### Bug Fixes

* reset default network ACL rule ingress to unlimited ([#8287](https://github.com/chanzuckerberg/shared-infra/issues/8287)) ([28cccf9](https://github.com/chanzuckerberg/shared-infra/commit/28cccf926f99d1642ea4b71b4eda3b02dc8f353a))

## [3.5.4](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.5.3...aws-env-v3.5.4) (2023-08-14)


### Bug Fixes

* group bastion vars together so logic is cleaner in vpc setup ([#8265](https://github.com/chanzuckerberg/shared-infra/issues/8265)) ([efe1b5f](https://github.com/chanzuckerberg/shared-infra/commit/efe1b5fa5e5d2bdea1dc25c06c47206d9f56632b))

## [3.5.3](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.5.2...aws-env-v3.5.3) (2023-08-11)


### Bug Fixes

* change aws-env's default ingress groups based on whether bastion is enabled ([#8241](https://github.com/chanzuckerberg/shared-infra/issues/8241)) ([7323947](https://github.com/chanzuckerberg/shared-infra/commit/73239475139da951733fa5c90a6e1a934cff9b8a))

## [3.5.2](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.5.1...aws-env-v3.5.2) (2023-08-08)


### Bug Fixes

* aws-env's vpc name collisions ([#8224](https://github.com/chanzuckerberg/shared-infra/issues/8224)) ([13a60ad](https://github.com/chanzuckerberg/shared-infra/commit/13a60ad6507964dbc8d2248ca7c80e38dd66aeb8))

## [3.5.1](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.5.0...aws-env-v3.5.1) (2023-08-08)


### Bug Fixes

* VPC flow log name changes in aws-env to prevent collisions + stay within bounds ([#8219](https://github.com/chanzuckerberg/shared-infra/issues/8219)) ([70651da](https://github.com/chanzuckerberg/shared-infra/commit/70651da050e357bb700cf0a9e6f766ec61c5ebce))

## [3.5.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.4.1...aws-env-v3.5.0) (2023-07-28)


### Features

* Upgrade gp2 volumes to gp3 in bastions, mariadb volumes, bastions, ecs clusters, eks storage classes and eks persistent volume claims ([#8156](https://github.com/chanzuckerberg/shared-infra/issues/8156)) ([fe8dfdd](https://github.com/chanzuckerberg/shared-infra/commit/fe8dfdd8100c5b1b3af6d9d459e100cc961e78c0))

## [3.4.1](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.4.0...aws-env-v3.4.1) (2023-06-21)


### Bug Fixes

* upgrade playground vpc module + create endpoints separately ([#7974](https://github.com/chanzuckerberg/shared-infra/issues/7974)) ([ffc7142](https://github.com/chanzuckerberg/shared-infra/commit/ffc71429022eecd5e27c12973030be6cfd4b2939))

## [3.4.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.3.3...aws-env-v3.4.0) (2023-06-14)


### Features

* allow for single nat gateway ([#7946](https://github.com/chanzuckerberg/shared-infra/issues/7946)) ([f3f2158](https://github.com/chanzuckerberg/shared-infra/commit/f3f21587a449098a206a970d3177a6b64b2c9e99))

## [3.3.3](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.3.2...aws-env-v3.3.3) (2023-06-14)


### Bug Fixes

* remove outputs that do not work ([#7942](https://github.com/chanzuckerberg/shared-infra/issues/7942)) ([8655ee1](https://github.com/chanzuckerberg/shared-infra/commit/8655ee1e4033970df1c4fc395caa9e77b0c034c4))

## [3.3.2](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.3.1...aws-env-v3.3.2) (2023-05-30)


### Bug Fixes

* remove unused variables added to aws-env ([#7882](https://github.com/chanzuckerberg/shared-infra/issues/7882)) ([f301eb6](https://github.com/chanzuckerberg/shared-infra/commit/f301eb6f4055841a59e14d3adb342430e0864f14))

## [3.3.1](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.3.0...aws-env-v3.3.1) (2023-05-25)


### Bug Fixes

* create AWS Service endpoints in VPCs by default ([#7857](https://github.com/chanzuckerberg/shared-infra/issues/7857)) ([73f6324](https://github.com/chanzuckerberg/shared-infra/commit/73f63241829cc1a749a2ad3bec32f628251b0387))

## [3.3.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.2.0...aws-env-v3.3.0) (2023-05-23)


### Features

* remove ssh_key_name as a required argument ([#7813](https://github.com/chanzuckerberg/shared-infra/issues/7813)) ([646f6b6](https://github.com/chanzuckerberg/shared-infra/commit/646f6b6d33ae6a48f948eae9e7a0289dc4a6ba48))

## [3.2.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.1.0...aws-env-v3.2.0) (2023-05-16)


### Features

* enable ssm endpoints in playground VPC ([#7809](https://github.com/chanzuckerberg/shared-infra/issues/7809)) ([865a3e5](https://github.com/chanzuckerberg/shared-infra/commit/865a3e52070f5d5c45de67bee71aeaa99d8f8ad8))

## [3.1.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v3.0.0...aws-env-v3.1.0) (2023-05-05)


### Features

* default bastion to off during aws account creation  ([#7767](https://github.com/chanzuckerberg/shared-infra/issues/7767)) ([d9326d0](https://github.com/chanzuckerberg/shared-infra/commit/d9326d042e7a6c7c53a23c13354b886ca39dc39b))

## [3.0.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.6.0...aws-env-v3.0.0) (2023-04-28)


### ⚠ BREAKING CHANGES

* k8s-core major version bump (#7726)

### Features

* k8s-core major version bump ([#7726](https://github.com/chanzuckerberg/shared-infra/issues/7726)) ([1c44772](https://github.com/chanzuckerberg/shared-infra/commit/1c4477285cf5a26411a73396bb631eea39a67e6b))

## [2.6.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.5.0...aws-env-v2.6.0) (2023-03-23)


### Features

* bump all shared-infra to 1.3.0 ([#7514](https://github.com/chanzuckerberg/shared-infra/issues/7514)) ([c56e63e](https://github.com/chanzuckerberg/shared-infra/commit/c56e63eac215442570762e62f27bab222f1837cb))

## [2.5.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.4.1...aws-env-v2.5.0) (2023-02-22)


### Features

* return ALB ARNs from the aws-env module ([#7250](https://github.com/chanzuckerberg/shared-infra/issues/7250)) ([563f5b5](https://github.com/chanzuckerberg/shared-infra/commit/563f5b5bd2710dbaba02994cbbb812f935d86e6c))

## [2.4.1](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.4.0...aws-env-v2.4.1) (2022-12-06)


### Bug Fixes

* Add an az check bypass for legacy VPCs ([#6868](https://github.com/chanzuckerberg/shared-infra/issues/6868)) ([d696eb9](https://github.com/chanzuckerberg/shared-infra/commit/d696eb903ba3d69031518dc50b766ca9b4398feb))

## [2.4.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.3.0...aws-env-v2.4.0) (2022-12-02)


### Features

* Forcing the release of aws-env module ([#6844](https://github.com/chanzuckerberg/shared-infra/issues/6844)) ([57f421a](https://github.com/chanzuckerberg/shared-infra/commit/57f421a8c8d2cad9bd58ab6aae033a4dae89bade))

## [2.3.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.2.3...aws-env-v2.3.0) (2022-09-12)


### Features

* added Secrets Manager endpoint variables ([#6235](https://github.com/chanzuckerberg/shared-infra/issues/6235)) ([fbaa798](https://github.com/chanzuckerberg/shared-infra/commit/fbaa798629e1f95f8faffe25396ced5e63bb78fb))

## [2.2.3](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.2.2...aws-env-v2.2.3) (2022-09-01)


### Bug Fixes

* namespacing in tfe-agents ([#6157](https://github.com/chanzuckerberg/shared-infra/issues/6157)) ([7e59401](https://github.com/chanzuckerberg/shared-infra/commit/7e59401116599fa04a5503d151e13128dabee025))

## [2.2.2](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.2.1...aws-env-v2.2.2) (2022-08-30)


### Bug Fixes

* Tweaking cloud env to support a parent component ([#6117](https://github.com/chanzuckerberg/shared-infra/issues/6117)) ([5975d8e](https://github.com/chanzuckerberg/shared-infra/commit/5975d8e78a2a2bf104a7fcf85672026cc35f1b77))

## [2.2.1](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.2.0...aws-env-v2.2.1) (2022-08-09)


### Bug Fixes

* add databricks to dev-cutter providers ([#5900](https://github.com/chanzuckerberg/shared-infra/issues/5900)) ([fe7d0cc](https://github.com/chanzuckerberg/shared-infra/commit/fe7d0ccea6a694728e7d7aab4a35a08f630d02d9))

## [2.2.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.1.0...aws-env-v2.2.0) (2022-07-15)


### Features

* remove subnet var from vpc endpoint config ([#5693](https://github.com/chanzuckerberg/shared-infra/issues/5693)) ([163e333](https://github.com/chanzuckerberg/shared-infra/commit/163e3334cc72af68aff7c3fc8fab9e94a1e1fb76))

## [2.1.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v2.0.0...aws-env-v2.1.0) (2022-07-14)


### Features

* Enable vpc endpoints for ECR and SSM ([#5677](https://github.com/chanzuckerberg/shared-infra/issues/5677)) ([c9b5843](https://github.com/chanzuckerberg/shared-infra/commit/c9b5843091a1a765cca0d4162e45e80fea0ff820))

## [2.0.0](https://github.com/chanzuckerberg/shared-infra/compare/aws-env-v1.0.0...aws-env-v2.0.0) (2022-04-28)


### ⚠ BREAKING CHANGES

* Enforce the match between the number of AZs, private and public subnets (#5119)

### Bug Fixes

* Enforce the match between the number of AZs, private and public subnets ([#5119](https://github.com/chanzuckerberg/shared-infra/issues/5119)) ([38732b9](https://github.com/chanzuckerberg/shared-infra/commit/38732b959eb06733244f1802f0e70d352d607785))
