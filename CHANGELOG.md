# Changelog

## [0.89.4](https://github.com/chanzuckerberg/cztack/compare/v0.89.3...v0.89.4) (2025-03-07)


### Bug Fixes

* variable name ([#702](https://github.com/chanzuckerberg/cztack/issues/702)) ([d866ae8](https://github.com/chanzuckerberg/cztack/commit/d866ae89a1b3ccf7165e0a201c7f3358445df5cf))

## [0.89.3](https://github.com/chanzuckerberg/cztack/compare/v0.89.2...v0.89.3) (2025-02-21)


### Bug Fixes

* CDI-3817 - Add support for overriding volume storage path on bucket ([#692](https://github.com/chanzuckerberg/cztack/issues/692)) ([e0d9635](https://github.com/chanzuckerberg/cztack/commit/e0d96359ec2ba3e3da8063654e9bb5d0b1544f25))
* specify asymmetric kms key here ([#699](https://github.com/chanzuckerberg/cztack/issues/699)) ([d0d121e](https://github.com/chanzuckerberg/cztack/commit/d0d121e098e2571fd8096781c93fb0b49649ca4e))

## [0.89.2](https://github.com/chanzuckerberg/cztack/compare/v0.89.1...v0.89.2) (2025-02-14)


### Bug Fixes

* make the KMS Okta App Integration module assume role part customizable ([#697](https://github.com/chanzuckerberg/cztack/issues/697)) ([1a31d4e](https://github.com/chanzuckerberg/cztack/commit/1a31d4ee0e1b39024733375a3985f0337df7f947))

## [0.89.1](https://github.com/chanzuckerberg/cztack/compare/v0.89.0...v0.89.1) (2025-02-12)


### Bug Fixes

* Update runs-on to use ARM64 or X64 ([#694](https://github.com/chanzuckerberg/cztack/issues/694)) ([71a6234](https://github.com/chanzuckerberg/cztack/commit/71a62349df6114e66f3561486e8b514c6efe0a5c))
* use the boolean var to decide whether we write variables to param store or not ([#696](https://github.com/chanzuckerberg/cztack/issues/696)) ([c8f7d43](https://github.com/chanzuckerberg/cztack/commit/c8f7d430539678b5eb256cdfa30f3822e3b68664))

## [0.89.0](https://github.com/chanzuckerberg/cztack/compare/v0.88.0...v0.89.0) (2025-02-05)


### Features

* create module for configuring an okta app with a kms key ([#691](https://github.com/chanzuckerberg/cztack/issues/691)) ([19ca30e](https://github.com/chanzuckerberg/cztack/commit/19ca30e4f43cc94e49733a91e68d8190f03af07c))

## [0.88.0](https://github.com/chanzuckerberg/cztack/compare/v0.87.7...v0.88.0) (2025-01-31)


### Features

* add availability zone selection to all dbx cluster compute policies ([#689](https://github.com/chanzuckerberg/cztack/issues/689)) ([d9eee69](https://github.com/chanzuckerberg/cztack/commit/d9eee690aca087574518981ea1cc3b258be38d06))

## [0.87.7](https://github.com/chanzuckerberg/cztack/compare/v0.87.6...v0.87.7) (2024-12-04)


### Bug Fixes

* not allowed to change var ([#685](https://github.com/chanzuckerberg/cztack/issues/685)) ([5e76ad3](https://github.com/chanzuckerberg/cztack/commit/5e76ad331de3e03d20d5890c0213e30a4d8e1e0d))

## [0.87.6](https://github.com/chanzuckerberg/cztack/compare/v0.87.5...v0.87.6) (2024-12-04)


### Bug Fixes

* add the source & target domains to tags, make comment shorter ([#682](https://github.com/chanzuckerberg/cztack/issues/682)) ([693d3da](https://github.com/chanzuckerberg/cztack/commit/693d3da662ce43030bef85b703a00803054514b6))
* remove non-applicable permission from dbx volume grant and add all privileges group ([#684](https://github.com/chanzuckerberg/cztack/issues/684)) ([993fa7a](https://github.com/chanzuckerberg/cztack/commit/993fa7a60c6dd1cd265f9045575a4a5e0551065e))

## [0.87.5](https://github.com/chanzuckerberg/cztack/compare/v0.87.4...v0.87.5) (2024-11-19)


### Bug Fixes

* use right if else ([#680](https://github.com/chanzuckerberg/cztack/issues/680)) ([019a7d9](https://github.com/chanzuckerberg/cztack/commit/019a7d9e6fb53d814aa897545d24b63d72b7575d))

## [0.87.4](https://github.com/chanzuckerberg/cztack/compare/v0.87.3...v0.87.4) (2024-11-19)


### Bug Fixes

* add an optional redirect bucket variable for the redirect module ([#678](https://github.com/chanzuckerberg/cztack/issues/678)) ([4e24726](https://github.com/chanzuckerberg/cztack/commit/4e247266ff718b5301aee636b2e89af7c6560dab))

## [0.87.3](https://github.com/chanzuckerberg/cztack/compare/v0.87.2...v0.87.3) (2024-11-06)


### Bug Fixes

* CDI-3508 - Databricks volume bucket name output ([#676](https://github.com/chanzuckerberg/cztack/issues/676)) ([c522ec8](https://github.com/chanzuckerberg/cztack/commit/c522ec84db33bc1d080599e8b0b931804f6d5668))

## [0.87.2](https://github.com/chanzuckerberg/cztack/compare/v0.87.1...v0.87.2) (2024-11-01)


### Bug Fixes

* concat two list of strings then turn it into set ([#674](https://github.com/chanzuckerberg/cztack/issues/674)) ([8cd5290](https://github.com/chanzuckerberg/cztack/commit/8cd52908d7b812141cfa7b7298bd785f89370c27))

## [0.87.1](https://github.com/chanzuckerberg/cztack/compare/v0.87.0...v0.87.1) (2024-10-31)


### Bug Fixes

* update s3 bucket name typo ([#672](https://github.com/chanzuckerberg/cztack/issues/672)) ([22affc7](https://github.com/chanzuckerberg/cztack/commit/22affc7de02f4c9a222462827aaeeb3291c64a8b))

## [0.87.0](https://github.com/chanzuckerberg/cztack/compare/v0.86.1...v0.87.0) (2024-10-31)


### Features

* biohub s3 readonly role ([#669](https://github.com/chanzuckerberg/cztack/issues/669)) ([d64e240](https://github.com/chanzuckerberg/cztack/commit/d64e240f310286aa5b75c139ab235bbbbbf77b7f))


### Bug Fixes

* add oidc input to assume role policy ([#671](https://github.com/chanzuckerberg/cztack/issues/671)) ([4d41154](https://github.com/chanzuckerberg/cztack/commit/4d41154cc90fa37c729e2b1ae9ada3035d214ff4))

## [0.86.1](https://github.com/chanzuckerberg/cztack/compare/v0.86.0...v0.86.1) (2024-10-25)


### Bug Fixes

* Ensure Databricks external location role exists before making it self-referential ([#667](https://github.com/chanzuckerberg/cztack/issues/667)) ([6834b5b](https://github.com/chanzuckerberg/cztack/commit/6834b5bd2bcecdb8231b054c6fb4b37105e28aaa))

## [0.86.0](https://github.com/chanzuckerberg/cztack/compare/v0.85.0...v0.86.0) (2024-10-24)


### Features

* update go lint ([#665](https://github.com/chanzuckerberg/cztack/issues/665)) ([eb4a894](https://github.com/chanzuckerberg/cztack/commit/eb4a89415b1e61d66bba5fafac44695b4a11837e))


### Bug Fixes

* databricks-catalog-external-location - Make role self-assuming ([#664](https://github.com/chanzuckerberg/cztack/issues/664)) ([7ff6b93](https://github.com/chanzuckerberg/cztack/commit/7ff6b93aa8aaa1ed843079c75d26bbd9861e4806))

## [0.85.0](https://github.com/chanzuckerberg/cztack/compare/v0.84.1...v0.85.0) (2024-10-17)


### Features

* trigger release please ([#662](https://github.com/chanzuckerberg/cztack/issues/662)) ([9d80dd2](https://github.com/chanzuckerberg/cztack/commit/9d80dd27581444dbd336edef281777d335a0af55))

## [0.84.1](https://github.com/chanzuckerberg/cztack/compare/v0.84.0...v0.84.1) (2024-10-17)


### Bug Fixes

* Move out power user group ([#659](https://github.com/chanzuckerberg/cztack/issues/659)) ([68a0747](https://github.com/chanzuckerberg/cztack/commit/68a0747eb2ec472a1bd14ea96d85a310144b76f0))

## [0.84.0](https://github.com/chanzuckerberg/cztack/compare/v0.83.5...v0.84.0) (2024-10-16)


### Features

* Add groups to databricks-default-cluster-policies module ([#655](https://github.com/chanzuckerberg/cztack/issues/655)) ([94ed7e5](https://github.com/chanzuckerberg/cztack/commit/94ed7e51176c5b5f5d6168768ef98beebb2a58e4))

## [0.83.5](https://github.com/chanzuckerberg/cztack/compare/v0.83.4...v0.83.5) (2024-10-16)


### Bug Fixes

* CDI-3452 - Fix references for dbx volumes to allow creating volume on existing catalog and bucket ([#656](https://github.com/chanzuckerberg/cztack/issues/656)) ([09ad9c8](https://github.com/chanzuckerberg/cztack/commit/09ad9c8b09146e261b552c8fa1cee308a1e47ce3))

## [0.83.4](https://github.com/chanzuckerberg/cztack/compare/v0.83.3...v0.83.4) (2024-10-14)


### Bug Fixes

* remove read_file permissions from dbx volume ([#653](https://github.com/chanzuckerberg/cztack/issues/653)) ([3ef78e5](https://github.com/chanzuckerberg/cztack/commit/3ef78e52e596457d4dadaed7067b9e3aba3374cb))

## [0.83.3](https://github.com/chanzuckerberg/cztack/compare/v0.83.2...v0.83.3) (2024-10-14)


### Bug Fixes

* refine and downscope UC grants for volume ([#651](https://github.com/chanzuckerberg/cztack/issues/651)) ([617cb81](https://github.com/chanzuckerberg/cztack/commit/617cb81a68ede7cc051f181786c1f0d9d4a522d2))

## [0.83.2](https://github.com/chanzuckerberg/cztack/compare/v0.83.1...v0.83.2) (2024-10-11)


### Bug Fixes

* fix volume catalog grant principal ([#649](https://github.com/chanzuckerberg/cztack/issues/649)) ([5447969](https://github.com/chanzuckerberg/cztack/commit/5447969fd35416d36e4932a7d99dbc5889521c9e))

## [0.83.1](https://github.com/chanzuckerberg/cztack/compare/v0.83.0...v0.83.1) (2024-10-01)


### Bug Fixes

* Conditionally create grant ([#647](https://github.com/chanzuckerberg/cztack/issues/647)) ([f068b40](https://github.com/chanzuckerberg/cztack/commit/f068b40c646e521acc84818f4f9014e629ab3925))

## [0.83.0](https://github.com/chanzuckerberg/cztack/compare/v0.82.2...v0.83.0) (2024-10-01)


### Features

* New module volumes on existing catalogs ([#645](https://github.com/chanzuckerberg/cztack/issues/645)) ([ae60a9c](https://github.com/chanzuckerberg/cztack/commit/ae60a9c7ecd9ad4d136eba7881a0ab25aa5a279d))

## [0.82.2](https://github.com/chanzuckerberg/cztack/compare/v0.82.1...v0.82.2) (2024-09-11)


### Bug Fixes

* Add depends_on to databricks_catalog ([#641](https://github.com/chanzuckerberg/cztack/issues/641)) ([dac9a81](https://github.com/chanzuckerberg/cztack/commit/dac9a81a3df791d43b4a64ae1a1d8e02c1c2b86c))

## [0.82.1](https://github.com/chanzuckerberg/cztack/compare/v0.82.0...v0.82.1) (2024-09-04)


### Bug Fixes

* resolve small clusters compute policy and legacy shared policy ([#639](https://github.com/chanzuckerberg/cztack/issues/639)) ([cc3643b](https://github.com/chanzuckerberg/cztack/commit/cc3643be94e4d4dbd753bfc3a58cea751a6d436a))

## [0.82.0](https://github.com/chanzuckerberg/cztack/compare/v0.81.0...v0.82.0) (2024-09-03)


### Features

* create service account role module for EKS ([#636](https://github.com/chanzuckerberg/cztack/issues/636)) ([d6ecfd3](https://github.com/chanzuckerberg/cztack/commit/d6ecfd31589857f1abfd819a059a7a61e19fddeb))

## [0.81.0](https://github.com/chanzuckerberg/cztack/compare/v0.80.0...v0.81.0) (2024-09-03)


### Features

* Add BROWSE to catalog perms ([#634](https://github.com/chanzuckerberg/cztack/issues/634)) ([041c3e9](https://github.com/chanzuckerberg/cztack/commit/041c3e96cd28d482bf8678f62f406ed183767e7d))

## [0.80.0](https://github.com/chanzuckerberg/cztack/compare/v0.79.0...v0.80.0) (2024-08-27)


### Features

* Catalog prefix option ([#631](https://github.com/chanzuckerberg/cztack/issues/631)) ([44b9e6b](https://github.com/chanzuckerberg/cztack/commit/44b9e6b239d32c3698b001ec9aba4027db32de9c))

## [0.79.0](https://github.com/chanzuckerberg/cztack/compare/v0.78.2...v0.79.0) (2024-08-22)


### Features

* trigger release and fix docs ([#629](https://github.com/chanzuckerberg/cztack/issues/629)) ([730a6d5](https://github.com/chanzuckerberg/cztack/commit/730a6d50328c566f93b3161599d7fa4390d5a494))

## [0.78.2](https://github.com/chanzuckerberg/cztack/compare/v0.78.1...v0.78.2) (2024-08-21)


### Bug Fixes

* update READMEs for aws-aurora, aws-aurora-postgres, aws-aurora-mysql ([#626](https://github.com/chanzuckerberg/cztack/issues/626)) ([7eed8f0](https://github.com/chanzuckerberg/cztack/commit/7eed8f0559b7f4bffc26d95929a2479f049a0239))

## [0.78.1](https://github.com/chanzuckerberg/cztack/compare/v0.78.0...v0.78.1) (2024-08-21)


### Bug Fixes

* move the auth token generation out of the redis module for integration reasons ([#623](https://github.com/chanzuckerberg/cztack/issues/623)) ([a3c33dd](https://github.com/chanzuckerberg/cztack/commit/a3c33dd419d4a7934883fc20fd4c4124ba356824))

## [0.78.0](https://github.com/chanzuckerberg/cztack/compare/v0.77.2...v0.78.0) (2024-08-20)


### ⚠ BREAKING CHANGES

* update redis replication group to use new aws provider (#613)

### Features

* update redis replication group to use new aws provider ([#613](https://github.com/chanzuckerberg/cztack/issues/613)) ([eca5fd0](https://github.com/chanzuckerberg/cztack/commit/eca5fd0d6b1f670346d6eb07a5839ad00086f654))


### Bug Fixes

* mysql cluster defaults ([#619](https://github.com/chanzuckerberg/cztack/issues/619)) ([7891044](https://github.com/chanzuckerberg/cztack/commit/789104478df33f5908a0833a9fc45b5d17832b79))

## [0.77.2](https://github.com/chanzuckerberg/cztack/compare/v0.77.1...v0.77.2) (2024-08-19)


### Bug Fixes

* Allow dbx storage credentials roles to be self-assuming ([#620](https://github.com/chanzuckerberg/cztack/issues/620)) ([47970b3](https://github.com/chanzuckerberg/cztack/commit/47970b36a5220c917605ad1a872acf7f2596f554))

## [0.77.1](https://github.com/chanzuckerberg/cztack/compare/v0.77.0...v0.77.1) (2024-08-19)


### Bug Fixes

* missing dollar sign for text interpolation ([#617](https://github.com/chanzuckerberg/cztack/issues/617)) ([2f27356](https://github.com/chanzuckerberg/cztack/commit/2f273564251a98a8c8418ef39dd9656a737f0ee4))

## [0.77.0](https://github.com/chanzuckerberg/cztack/compare/v0.76.0...v0.77.0) (2024-08-19)


### Features

* Create databricks catalog ext loc modules ([#614](https://github.com/chanzuckerberg/cztack/issues/614)) ([8b47a1c](https://github.com/chanzuckerberg/cztack/commit/8b47a1cfc0708bbd7ef3a877821e8af3bb10ffcc))


### Bug Fixes

* Make github-app-token one version ([#615](https://github.com/chanzuckerberg/cztack/issues/615)) ([ce5296c](https://github.com/chanzuckerberg/cztack/commit/ce5296c51ca5d56948451c563824eb34f78999a7))

## [0.76.0](https://github.com/chanzuckerberg/cztack/compare/v0.75.0...v0.76.0) (2024-07-24)


### Features

* add condition_operator field to allow overriding StringEquals with StringLike ([#610](https://github.com/chanzuckerberg/cztack/issues/610)) ([86bab99](https://github.com/chanzuckerberg/cztack/commit/86bab991235dba69305970153f88d650dfa65802))

## [0.75.0](https://github.com/chanzuckerberg/cztack/compare/v0.74.0...v0.75.0) (2024-07-24)


### Features

* add jwt_condition option to oidc variable for IAM trust relationships ([#608](https://github.com/chanzuckerberg/cztack/issues/608)) ([5320504](https://github.com/chanzuckerberg/cztack/commit/5320504677c9fda2447b61229ed1831b24f36074))

## [0.74.0](https://github.com/chanzuckerberg/cztack/compare/v0.73.3...v0.74.0) (2024-07-18)


### Features

* CDI-3149 - Allow use of existing catalogs and schemas for databricks volumes ([#606](https://github.com/chanzuckerberg/cztack/issues/606)) ([7735218](https://github.com/chanzuckerberg/cztack/commit/7735218680130e8fc94d00f392c9537f45b6c1e8))

## [0.73.3](https://github.com/chanzuckerberg/cztack/compare/v0.73.2...v0.73.3) (2024-07-03)


### Bug Fixes

* CDI-3123 - fix service principal TF type ([#604](https://github.com/chanzuckerberg/cztack/issues/604)) ([06858ca](https://github.com/chanzuckerberg/cztack/commit/06858ca3a6602416743198fbf5c683bc87471790))

## [0.73.2](https://github.com/chanzuckerberg/cztack/compare/v0.73.1...v0.73.2) (2024-07-03)


### Bug Fixes

* dbx service principal ref ([#602](https://github.com/chanzuckerberg/cztack/issues/602)) ([8929d7a](https://github.com/chanzuckerberg/cztack/commit/8929d7a8e6e07bd9bc052601c75f5b85376e4e6e))

## [0.73.1](https://github.com/chanzuckerberg/cztack/compare/v0.73.0...v0.73.1) (2024-07-03)


### Bug Fixes

* resource block name missing ([#600](https://github.com/chanzuckerberg/cztack/issues/600)) ([0c43eeb](https://github.com/chanzuckerberg/cztack/commit/0c43eeb7f5e93692e7d5831dc6031f8794b48265))

## [0.73.0](https://github.com/chanzuckerberg/cztack/compare/v0.72.1...v0.73.0) (2024-07-02)


### Features

* add service principal to workspace module ([#598](https://github.com/chanzuckerberg/cztack/issues/598)) ([e9ea41a](https://github.com/chanzuckerberg/cztack/commit/e9ea41a2993d0751c8ee0fbb653ab3e5cb4b726e))

## [0.72.1](https://github.com/chanzuckerberg/cztack/compare/v0.72.0...v0.72.1) (2024-06-25)


### Bug Fixes

* add wait for race condition and clean up names ([#595](https://github.com/chanzuckerberg/cztack/issues/595)) ([61c5437](https://github.com/chanzuckerberg/cztack/commit/61c543776ce487f9b9cd5456fcd0321eb6c79240))

## [0.72.0](https://github.com/chanzuckerberg/cztack/compare/v0.71.0...v0.72.0) (2024-06-25)


### Features

* CDI-3103 - New databricks volume module ([#593](https://github.com/chanzuckerberg/cztack/issues/593)) ([2d72a6c](https://github.com/chanzuckerberg/cztack/commit/2d72a6cf5a4d50f3d24bb6108b4c03ced39c79aa))

## [0.71.0](https://github.com/chanzuckerberg/cztack/compare/v0.70.0...v0.71.0) (2024-06-03)


### Features

* Update default CA identifier for aws-aurora modules to rds-ca-rsa2048-g1 ([#591](https://github.com/chanzuckerberg/cztack/issues/591)) ([61cf124](https://github.com/chanzuckerberg/cztack/commit/61cf124e8721bf43a6c78f181c1f05d1da8a57a0))

## [0.70.0](https://github.com/chanzuckerberg/cztack/compare/v0.69.4...v0.70.0) (2024-05-31)


### Features

* Upgrade RDS CAs to rds-ca-ecc384-g1 ([#589](https://github.com/chanzuckerberg/cztack/issues/589)) ([5f5e7b4](https://github.com/chanzuckerberg/cztack/commit/5f5e7b48176332f5855dae2cc81afa7983d00b23))

## [0.69.4](https://github.com/chanzuckerberg/cztack/compare/v0.69.3...v0.69.4) (2024-05-02)


### Bug Fixes

* Add more tags for single node ([#587](https://github.com/chanzuckerberg/cztack/issues/587)) ([a71d74c](https://github.com/chanzuckerberg/cztack/commit/a71d74c0d72a3631696e47207b50ba54e6ef5e77))

## [0.69.3](https://github.com/chanzuckerberg/cztack/compare/v0.69.2...v0.69.3) (2024-05-01)


### Bug Fixes

* don't allow dashes in sids ([7959ea0](https://github.com/chanzuckerberg/cztack/commit/7959ea0c3e716be46f6e10ec3ec02ba7cd5bdfa4))

## [0.69.2](https://github.com/chanzuckerberg/cztack/compare/v0.69.1...v0.69.2) (2024-04-30)


### Bug Fixes

* key the sid so they are unique ([219cc4c](https://github.com/chanzuckerberg/cztack/commit/219cc4c55e6cf4af2e9a6d03091422c8564a20c2))

## [0.69.1](https://github.com/chanzuckerberg/cztack/compare/v0.69.0...v0.69.1) (2024-04-24)


### Bug Fixes

* update custom job policy to work with jobs ([#581](https://github.com/chanzuckerberg/cztack/issues/581)) ([2539942](https://github.com/chanzuckerberg/cztack/commit/2539942613365bd7b6c711f25ad454f90abfcc35))

## [0.69.0](https://github.com/chanzuckerberg/cztack/compare/v0.68.0...v0.69.0) (2024-04-23)


### Features

* Add a new single node policy to databricks-default-cluster-policies ([#579](https://github.com/chanzuckerberg/cztack/issues/579)) ([2723df6](https://github.com/chanzuckerberg/cztack/commit/2723df6cccf9217e4aa217f96b37fd472e3f37d5))

## [0.68.0](https://github.com/chanzuckerberg/cztack/compare/v0.67.1...v0.68.0) (2024-04-19)


### Features

* Allowing on demand instances for Job Compoute databricks compute policy ([#577](https://github.com/chanzuckerberg/cztack/issues/577)) ([639a9ac](https://github.com/chanzuckerberg/cztack/commit/639a9ac4f7741cdfc6104c20fc59e518eb69e6a8))

## [0.67.1](https://github.com/chanzuckerberg/cztack/compare/v0.67.0...v0.67.1) (2024-04-11)


### Bug Fixes

* make aws-iam-role adaptable to oidc & saml changes ([#574](https://github.com/chanzuckerberg/cztack/issues/574)) ([173f2da](https://github.com/chanzuckerberg/cztack/commit/173f2da3ba6e0cf280126680f7d5791618d16823))

## [0.67.0](https://github.com/chanzuckerberg/cztack/compare/v0.66.0...v0.67.0) (2024-03-27)


### Features

* Export kms key arn ([#572](https://github.com/chanzuckerberg/cztack/issues/572)) ([ec0aea5](https://github.com/chanzuckerberg/cztack/commit/ec0aea5167b9ae64529cdac2441a59b67424f040))

## [0.66.0](https://github.com/chanzuckerberg/cztack/compare/v0.65.5...v0.66.0) (2024-03-22)


### Features

* Add kms_encryption variable to cloudfront logs bucket ([#570](https://github.com/chanzuckerberg/cztack/issues/570)) ([eea7209](https://github.com/chanzuckerberg/cztack/commit/eea72096c132d14c20648be3c1a807c087ee0506))

## [0.65.5](https://github.com/chanzuckerberg/cztack/compare/v0.65.4...v0.65.5) (2024-03-21)


### Bug Fixes

* Choose one type of encryption for buckets ([#568](https://github.com/chanzuckerberg/cztack/issues/568)) ([125b37b](https://github.com/chanzuckerberg/cztack/commit/125b37becdb8868bb77431b85b9a064f83140dbf))

## [0.65.4](https://github.com/chanzuckerberg/cztack/compare/v0.65.3...v0.65.4) (2024-03-07)


### Bug Fixes

* add counter to resource ([0ab051a](https://github.com/chanzuckerberg/cztack/commit/0ab051aab7c11e550fcab20c4eaeef562c4d3e39))

## [0.65.3](https://github.com/chanzuckerberg/cztack/compare/v0.65.2...v0.65.3) (2024-03-07)


### Bug Fixes

* CDI-2604 Databricks cluster policy permission grants not being applied correctly ([#563](https://github.com/chanzuckerberg/cztack/issues/563)) ([d85282f](https://github.com/chanzuckerberg/cztack/commit/d85282f022ff7141d007bd2b9015c04325df8f72))

## [0.65.2](https://github.com/chanzuckerberg/cztack/compare/v0.65.1...v0.65.2) (2024-01-26)


### Bug Fixes

* Index endpoint ([#561](https://github.com/chanzuckerberg/cztack/issues/561)) ([6bde265](https://github.com/chanzuckerberg/cztack/commit/6bde2659e5b63e029d6d56797cb1f607e2f3eb60))

## [0.65.1](https://github.com/chanzuckerberg/cztack/compare/v0.65.0...v0.65.1) (2024-01-26)


### Bug Fixes

* ref to cluster instance ([#559](https://github.com/chanzuckerberg/cztack/issues/559)) ([bdaf441](https://github.com/chanzuckerberg/cztack/commit/bdaf441f0e4788adff6aafac97b2443a73070804))

## [0.65.0](https://github.com/chanzuckerberg/cztack/compare/v0.64.0...v0.65.0) (2024-01-26)


### Features

* Export aws_rds_cluster_instance in aurora postgres module ([#557](https://github.com/chanzuckerberg/cztack/issues/557)) ([e2ef7d0](https://github.com/chanzuckerberg/cztack/commit/e2ef7d0262b34a784cc31982e744d19ac04ae940))

## [0.64.0](https://github.com/chanzuckerberg/cztack/compare/v0.63.4...v0.64.0) (2024-01-26)


### Features

* Fix download of snowflake terraform provider ([#556](https://github.com/chanzuckerberg/cztack/issues/556)) ([4fcc1e0](https://github.com/chanzuckerberg/cztack/commit/4fcc1e05a58069f63d81126fd1b03b77c77e8ea8))
* Output aurora db instance ([#554](https://github.com/chanzuckerberg/cztack/issues/554)) ([e226871](https://github.com/chanzuckerberg/cztack/commit/e22687186e7290f348b647634b1573f248383a90))

## [0.63.4](https://github.com/chanzuckerberg/cztack/compare/v0.63.3...v0.63.4) (2024-01-19)


### Bug Fixes

* [ONCALL-693] Trigger release of databricks-default-cluster-policies ([#552](https://github.com/chanzuckerberg/cztack/issues/552)) ([3080122](https://github.com/chanzuckerberg/cztack/commit/3080122f6c7805947d38f720545c8ab5e8a0969f))

## [0.63.3](https://github.com/chanzuckerberg/cztack/compare/v0.63.2...v0.63.3) (2024-01-10)


### Bug Fixes

* remove deprecated overwrite param in this module ([#548](https://github.com/chanzuckerberg/cztack/issues/548)) ([a47c396](https://github.com/chanzuckerberg/cztack/commit/a47c3968f435fec09c829650f125ff9be33546e8))

## [0.63.1](https://github.com/chanzuckerberg/cztack/compare/v0.63.0...v0.63.1) (2023-11-16)


### Bug Fixes

* personal instance pools var for databricks compute policies ([#543](https://github.com/chanzuckerberg/cztack/issues/543)) ([541f8d3](https://github.com/chanzuckerberg/cztack/commit/541f8d393351d9492e55cbaa452ff0187106fed0))

## [0.63.0](https://github.com/chanzuckerberg/cztack/compare/v0.62.3...v0.63.0) (2023-11-15)


### Features

* add pool use to personal compute Databricks policy ([#542](https://github.com/chanzuckerberg/cztack/issues/542)) ([9d4cd22](https://github.com/chanzuckerberg/cztack/commit/9d4cd22daedfcfa9e5f125f6650ec547bcd35e4c))

## [0.62.3](https://github.com/chanzuckerberg/cztack/compare/v0.62.2...v0.62.3) (2023-11-03)


### Bug Fixes

* module name fix ([42b328d](https://github.com/chanzuckerberg/cztack/commit/42b328dd1edf200e9672ecd48dba743c0b053500))

## [0.62.2](https://github.com/chanzuckerberg/cztack/compare/v0.62.1...v0.62.2) (2023-11-03)


### Bug Fixes

* Split out job compute policy between single and multi node ([#537](https://github.com/chanzuckerberg/cztack/issues/537)) ([770b19e](https://github.com/chanzuckerberg/cztack/commit/770b19e544cca18a6f6e7f3f59800e84f16c1393))

## [0.62.1](https://github.com/chanzuckerberg/cztack/compare/v0.62.0...v0.62.1) (2023-10-31)


### Bug Fixes

* remove unused databricks-workspace-e2 variable ([#535](https://github.com/chanzuckerberg/cztack/issues/535)) ([a21509b](https://github.com/chanzuckerberg/cztack/commit/a21509bda6d4bbeb81aaa2afc5fb9bd19f4f86f8))

## [0.62.0](https://github.com/chanzuckerberg/cztack/compare/v0.61.0...v0.62.0) (2023-10-31)


### Features

* CDI-2182 Add databricks-default-cluster-policy module ([#531](https://github.com/chanzuckerberg/cztack/issues/531)) ([4c70f29](https://github.com/chanzuckerberg/cztack/commit/4c70f295cefb5013590e6533b6ae6e09efc52a0c))
* CDI-2183 Add databricks-cluster-log-permissions module ([#532](https://github.com/chanzuckerberg/cztack/issues/532)) ([2e5974a](https://github.com/chanzuckerberg/cztack/commit/2e5974a61defa36d339a1a28ce7c90a17bd22685))


### Bug Fixes

* update readmes and trigger release ([#534](https://github.com/chanzuckerberg/cztack/issues/534)) ([7fef82a](https://github.com/chanzuckerberg/cztack/commit/7fef82aa47a9dcc5b9e897072406f080e4ddef1f))

## [0.61.0](https://github.com/chanzuckerberg/cztack/compare/v0.60.1...v0.61.0) (2023-10-30)


### Features

* all more options when creating the trust relationship ([#525](https://github.com/chanzuckerberg/cztack/issues/525)) ([edfff23](https://github.com/chanzuckerberg/cztack/commit/edfff23a634152c02a75c78246d5784b0c2f75db))

## [0.60.1](https://github.com/chanzuckerberg/cztack/compare/v0.60.0...v0.60.1) (2023-10-03)


### Bug Fixes

* trigger release for S3 default KMS encryption fix ([#521](https://github.com/chanzuckerberg/cztack/issues/521)) ([8bf754e](https://github.com/chanzuckerberg/cztack/commit/8bf754e85495d19181c410c08d4f365c14ca36f9))

## [0.60.0](https://github.com/chanzuckerberg/cztack/compare/v0.59.0...v0.60.0) (2023-09-22)


### Features

* Remove deprecated overwrite parameter ([#519](https://github.com/chanzuckerberg/cztack/issues/519)) ([2dc7203](https://github.com/chanzuckerberg/cztack/commit/2dc7203d4f9092a7b9fe4ccc79cc3d5d4b2bbde2))

## [0.59.0](https://github.com/chanzuckerberg/cztack/compare/v0.58.0...v0.59.0) (2023-08-28)


### Features

* Support image tag mutability and scan settings ([#517](https://github.com/chanzuckerberg/cztack/issues/517)) ([64e5e47](https://github.com/chanzuckerberg/cztack/commit/64e5e479124da2b3626c9d0e52e2f94f60cfea19))

## [0.58.0](https://github.com/chanzuckerberg/cztack/compare/v0.57.4...v0.58.0) (2023-06-28)


### Features

* AWS provider version bump to support BucketOwnerEnforced object ownership value ([#512](https://github.com/chanzuckerberg/cztack/issues/512)) ([9053640](https://github.com/chanzuckerberg/cztack/commit/9053640a832b66f87752dd5a6c144726e0aff7e5))
* CDI-1607 Add KMS encryption key var to s3 bucket ([#514](https://github.com/chanzuckerberg/cztack/issues/514)) ([c946dd0](https://github.com/chanzuckerberg/cztack/commit/c946dd059746626f3aa0bc65fe266cce5e4171cd))

## [0.57.4](https://github.com/chanzuckerberg/cztack/compare/v0.57.3...v0.57.4) (2023-06-14)


### Bug Fixes

* Use id and not resource itself as value ([#510](https://github.com/chanzuckerberg/cztack/issues/510)) ([c039cf6](https://github.com/chanzuckerberg/cztack/commit/c039cf60861c72cc5b82096e4d72d3a1c447b398))

## [0.57.3](https://github.com/chanzuckerberg/cztack/compare/v0.57.2...v0.57.3) (2023-06-12)


### Bug Fixes

* Ternary operator for variable validation check against null ([#508](https://github.com/chanzuckerberg/cztack/issues/508)) ([e25a681](https://github.com/chanzuckerberg/cztack/commit/e25a68166c2cbdd257b1201dd52c88ebb1763cdf))

## [0.57.2](https://github.com/chanzuckerberg/cztack/compare/v0.57.1...v0.57.2) (2023-06-12)


### Bug Fixes

* default value comparison ([#506](https://github.com/chanzuckerberg/cztack/issues/506)) ([0e9e2d4](https://github.com/chanzuckerberg/cztack/commit/0e9e2d4c08e18f4e1a0970fab497233f27db8dbb))

## [0.57.1](https://github.com/chanzuckerberg/cztack/compare/v0.57.0...v0.57.1) (2023-06-12)


### Bug Fixes

* Add null default as accepted value ([#504](https://github.com/chanzuckerberg/cztack/issues/504)) ([f15b985](https://github.com/chanzuckerberg/cztack/commit/f15b9856069399bc8d20c6833a50b86a049f4b6c))

## [0.57.0](https://github.com/chanzuckerberg/cztack/compare/v0.56.2...v0.57.0) (2023-06-12)


### Features

* aws-s3-private-bucket Allow specifying bucket object blanket ownership ([#502](https://github.com/chanzuckerberg/cztack/issues/502)) ([f7f45b8](https://github.com/chanzuckerberg/cztack/commit/f7f45b854cd8297bca40d4bad19ed1a3e834e31f))

## [0.56.2](https://github.com/chanzuckerberg/cztack/compare/v0.56.1...v0.56.2) (2023-05-30)


### Bug Fixes

* Handle empty and blank source policies ([#498](https://github.com/chanzuckerberg/cztack/issues/498)) ([6ac0451](https://github.com/chanzuckerberg/cztack/commit/6ac0451a649afc5048fabc6da2aac6b36c16fa04))

## [0.56.1](https://github.com/chanzuckerberg/cztack/compare/v0.56.0...v0.56.1) (2023-05-30)


### Bug Fixes

* Replace a deprecated source_json attribute ([#495](https://github.com/chanzuckerberg/cztack/issues/495)) ([93381a4](https://github.com/chanzuckerberg/cztack/commit/93381a40c697599591fa7872618f0d580c9ca4e4))

## [0.56.0](https://github.com/chanzuckerberg/cztack/compare/v0.55.1...v0.56.0) (2023-05-26)


### Features

* output additional info from aws-aurora-postgres ([#491](https://github.com/chanzuckerberg/cztack/issues/491)) ([4d131c5](https://github.com/chanzuckerberg/cztack/commit/4d131c57bf039e9a08416819ab2eb0829fa7d5c4))


### Bug Fixes

* address issue with public access block on public s3 bucket ([#492](https://github.com/chanzuckerberg/cztack/issues/492)) ([e1c5c5c](https://github.com/chanzuckerberg/cztack/commit/e1c5c5ca30f09ead473b98cc9f011f94479a8d34))
* cut out cztack-ci-2 from workflow, use standard way to authorize cztack-ci-1 ([#486](https://github.com/chanzuckerberg/cztack/issues/486)) ([ce8e47b](https://github.com/chanzuckerberg/cztack/commit/ce8e47b3463fc5caa1ee7f1798f21a890d6a27ae))
* fixing acl issue on cloudfront buckets ([#493](https://github.com/chanzuckerberg/cztack/issues/493)) ([22187dd](https://github.com/chanzuckerberg/cztack/commit/22187ddf3b23ef26ae0a33c6e9de554c8d075962))
* rotator deprecation - oidc auth to aws in cztack workflow runs ([#488](https://github.com/chanzuckerberg/cztack/issues/488)) ([c72fa79](https://github.com/chanzuckerberg/cztack/commit/c72fa7929d456c6bbda97c3e57fa34bf9ed295ad))
* Source_json is removed in aws provider 5.0.x ([#494](https://github.com/chanzuckerberg/cztack/issues/494)) ([70a6dae](https://github.com/chanzuckerberg/cztack/commit/70a6dae5ef46704a608df0c1f81ee1002686f845))

## [0.55.1](https://github.com/chanzuckerberg/cztack/compare/v0.55.0...v0.55.1) (2023-05-03)


### Bug Fixes

* sid alphanumeric ([#484](https://github.com/chanzuckerberg/cztack/issues/484)) ([2266f9d](https://github.com/chanzuckerberg/cztack/commit/2266f9d0b607869a7c6ebc3defb9dba32f4e9e24))

## [0.55.0](https://github.com/chanzuckerberg/cztack/compare/v0.54.0...v0.55.0) (2023-05-02)


### Features

* add dynamodb policy ([#482](https://github.com/chanzuckerberg/cztack/issues/482)) ([9858f8d](https://github.com/chanzuckerberg/cztack/commit/9858f8d5fa535d562a4f632f5a5d398d9d155816))

## [0.54.0](https://github.com/chanzuckerberg/cztack/compare/v0.53.2...v0.54.0) (2023-04-25)


### Features

* make github CI role opensource ([#480](https://github.com/chanzuckerberg/cztack/issues/480)) ([746d5a9](https://github.com/chanzuckerberg/cztack/commit/746d5a969ad79325fdf451e9e41df88b779ba49b))

## [0.53.2](https://github.com/chanzuckerberg/cztack/compare/v0.53.1...v0.53.2) (2023-04-21)


### Bug Fixes

* bump version ([58486a4](https://github.com/chanzuckerberg/cztack/commit/58486a4852566791707d868eaba7146e1b2c00a7))

## [0.53.1](https://github.com/chanzuckerberg/cztack/compare/v0.53.0...v0.53.1) (2023-04-18)


### Bug Fixes

* remove lock file ([eafedd3](https://github.com/chanzuckerberg/cztack/commit/eafedd30375dbc90588047d98bca263098a4cae5))

## [0.53.0](https://github.com/chanzuckerberg/cztack/compare/v0.52.0...v0.53.0) (2023-03-31)


### Features

* Allow lambda resource collection to be turned off (per account) - [CCIE-1198] ([#471](https://github.com/chanzuckerberg/cztack/issues/471)) ([1882eb8](https://github.com/chanzuckerberg/cztack/commit/1882eb86cffd9382dc75c0c5d5b89116324fb87f))

## [0.52.0](https://github.com/chanzuckerberg/cztack/compare/v0.51.1...v0.52.0) (2023-03-18)


### Features

* allow force_destroy option on s3 buckets ([#461](https://github.com/chanzuckerberg/cztack/issues/461)) ([3a0b34f](https://github.com/chanzuckerberg/cztack/commit/3a0b34f28663e66381c29fac665522b9916cb17b))

## [0.51.1](https://github.com/chanzuckerberg/cztack/compare/v0.51.0...v0.51.1) (2023-03-06)


### Bug Fixes

* Upgrade github runner ([#465](https://github.com/chanzuckerberg/cztack/issues/465)) ([7c00bf8](https://github.com/chanzuckerberg/cztack/commit/7c00bf874edb0af26e3cdd8ac8ef461c4370dea9))

## [0.51.0](https://github.com/chanzuckerberg/cztack/compare/v0.50.1...v0.51.0) (2023-03-05)


### Features

* add module for ecr repository ([#462](https://github.com/chanzuckerberg/cztack/issues/462)) ([dead0af](https://github.com/chanzuckerberg/cztack/commit/dead0af183db9d3c92e1489705307f351fe65755))

## [0.50.1](https://github.com/chanzuckerberg/cztack/compare/v0.50.0...v0.50.1) (2023-02-22)


### Bug Fixes

* update docs and add ALB ARNs to ECS services ([#457](https://github.com/chanzuckerberg/cztack/issues/457)) ([f052fd6](https://github.com/chanzuckerberg/cztack/commit/f052fd6a5ae8683030e40f3f4e690d8f87f4b8a6))

## [0.50.0](https://github.com/chanzuckerberg/cztack/compare/v0.49.2...v0.50.0) (2023-02-15)


### Features

* configure log retention in aws-lambda-edge-add-security-headers module ([#454](https://github.com/chanzuckerberg/cztack/issues/454)) ([3cf7dc1](https://github.com/chanzuckerberg/cztack/commit/3cf7dc14539d73cc84e09d9530486c41f98784f2))

## [0.49.2](https://github.com/chanzuckerberg/cztack/compare/v0.49.1...v0.49.2) (2022-12-14)


### Bug Fixes

* pin snowflake to 0.53.0 pt 2 ([#447](https://github.com/chanzuckerberg/cztack/issues/447)) ([7146e6f](https://github.com/chanzuckerberg/cztack/commit/7146e6fed280b898bfbbc6594a29fb41c6e8ae40))

## [0.49.1](https://github.com/chanzuckerberg/cztack/compare/v0.49.0...v0.49.1) (2022-11-16)


### Bug Fixes

* Add mission permission to allow ECS Fargate container exec ([#440](https://github.com/chanzuckerberg/cztack/issues/440)) ([24b3036](https://github.com/chanzuckerberg/cztack/commit/24b30369d02ec60682158b76be7cea1d21e5a5b5))

## [0.49.0](https://github.com/chanzuckerberg/cztack/compare/v0.48.0...v0.49.0) (2022-11-03)


### Features

* add db user and pw to outputs ([#434](https://github.com/chanzuckerberg/cztack/issues/434)) ([9232175](https://github.com/chanzuckerberg/cztack/commit/92321759b70387533c11528cd901c907249f66d1))

## [0.48.0](https://github.com/chanzuckerberg/cztack/compare/v0.47.0...v0.48.0) (2022-10-17)


### Features

* update github release to 3.5.0 ([#431](https://github.com/chanzuckerberg/cztack/issues/431)) ([24955b7](https://github.com/chanzuckerberg/cztack/commit/24955b7f6845ff5cd3ffc48902dad0e55acf0851))

## [0.47.0](https://github.com/chanzuckerberg/cztack/compare/v0.46.0...v0.47.0) (2022-09-19)


### Features

* add source role arns ([#423](https://github.com/chanzuckerberg/cztack/issues/423)) ([965da8f](https://github.com/chanzuckerberg/cztack/commit/965da8fe1033c5e39d22878fe6f19af05f1aaa45))

## [0.46.0](https://github.com/chanzuckerberg/cztack/compare/v0.45.0...v0.46.0) (2022-09-06)


### Features

* Add ability to pass size of ephemeral storage to ECS ([#417](https://github.com/chanzuckerberg/cztack/issues/417)) ([d87e56e](https://github.com/chanzuckerberg/cztack/commit/d87e56e4f968b7b1c57f90c6cbdba98d682f33b0))
* limit the number of character to the maximum 32 chars ([#420](https://github.com/chanzuckerberg/cztack/issues/420)) ([f0aa9d3](https://github.com/chanzuckerberg/cztack/commit/f0aa9d33869f00e73f674c1f85d167099945fb52))

## [0.45.0](https://github.com/chanzuckerberg/cztack/compare/v0.44.1...v0.45.0) (2022-07-07)


### Features

* Attach ssm permissions to ecs fargate job module ([#407](https://github.com/chanzuckerberg/cztack/issues/407)) ([5696d1d](https://github.com/chanzuckerberg/cztack/commit/5696d1db18ded14983fcd5c480468753c20eef53))

### [0.44.1](https://github.com/chanzuckerberg/cztack/compare/v0.44.0...v0.44.1) (2022-06-07)


### Bug Fixes

* Update Snowflake Terraform provider source to Snowflake-Labs ([#400](https://github.com/chanzuckerberg/cztack/issues/400)) ([fb7b329](https://github.com/chanzuckerberg/cztack/commit/fb7b329dc5a7eccc63fd267eb1e0dc6a9dc8c44f))

## [0.44.0](https://github.com/chanzuckerberg/cztack/compare/v0.43.3...v0.44.0) (2022-05-16)


### ⚠ BREAKING CHANGES

* Delete deprecated aws-acm-cert module (#379)

### Features

* adding conventional commit requirement ([#394](https://github.com/chanzuckerberg/cztack/issues/394)) ([39b962c](https://github.com/chanzuckerberg/cztack/commit/39b962cf109cc26431d7cc9b68e4f91ad9bc964b))
* Update `aws-aurora` module to not use `params_engine_version` ([#396](https://github.com/chanzuckerberg/cztack/issues/396)) ([d560e42](https://github.com/chanzuckerberg/cztack/commit/d560e423636864960f7027846e0e099a87c1211b))
* Variablize deletion_protection for aurora-postgres module ([#385](https://github.com/chanzuckerberg/cztack/issues/385)) ([6aea3cb](https://github.com/chanzuckerberg/cztack/commit/6aea3cb0f0b935e1b32967bb53c2c3732f4516da))


### Bug Fixes

* broken deps ([56247fd](https://github.com/chanzuckerberg/cztack/commit/56247fdc65790a6f1315ce8160aed4e48bd699e3))
* Generate docs ([#390](https://github.com/chanzuckerberg/cztack/issues/390)) ([eb1c5e2](https://github.com/chanzuckerberg/cztack/commit/eb1c5e2148aab0304a5899feb9d0ee10d1d74f93))
* linting dep on hard coded token ([#389](https://github.com/chanzuckerberg/cztack/issues/389)) ([8560dc1](https://github.com/chanzuckerberg/cztack/commit/8560dc1ab3b18328f8fc07fef44b824de822f2fe))
* mods not needed anymore ([#392](https://github.com/chanzuckerberg/cztack/issues/392)) ([68dd94f](https://github.com/chanzuckerberg/cztack/commit/68dd94f62dc5fd70673d3d44206da0795dca878a))
* release-please version and token ([#388](https://github.com/chanzuckerberg/cztack/issues/388)) ([b1d87d2](https://github.com/chanzuckerberg/cztack/commit/b1d87d22541d7c979d73ad253331f608931b7b70))
* remove dep on buildbot token ([#387](https://github.com/chanzuckerberg/cztack/issues/387)) ([dcce3cc](https://github.com/chanzuckerberg/cztack/commit/dcce3cca7148ced512c979bd87da8a39d921631a))
* update go version to fix tests breaking ([#393](https://github.com/chanzuckerberg/cztack/issues/393)) ([253aadc](https://github.com/chanzuckerberg/cztack/commit/253aadc1e9bb6d476bafe4c05edbcc1f19f092a0))


### Miscellaneous Chores

* Delete deprecated aws-acm-cert module ([#379](https://github.com/chanzuckerberg/cztack/issues/379)) ([1c75374](https://github.com/chanzuckerberg/cztack/commit/1c753748233e10e4c03662ef9c207be8f5183366))

### [0.43.3](https://www.github.com/chanzuckerberg/cztack/compare/v0.43.2...v0.43.3) (2021-11-01)


### Bug Fixes

* release-please version pin ([#345](https://www.github.com/chanzuckerberg/cztack/issues/345)) ([14ac3b6](https://www.github.com/chanzuckerberg/cztack/commit/14ac3b66b1b236d2361797a4aed438017b107a9f))

## 0.42.0 2021-07-20

* [8e3894ed](../../commit/8e3894edcdcaf5a7e8b40cba6de80d90e3452355) aws-single-page-static-site remove region from provider

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
