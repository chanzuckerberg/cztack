// required provider: https://github.com/chanzuckerberg/terraform-provider-bless
// generates the CA keypair and encrypts them with KMS
// no sensitive material is persisted to the terraform value store
resource "bless_ca" "bless" {
  kms_key_id =  aws_kms_key.bless.key_id
}
