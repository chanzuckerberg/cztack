variable "kms_key_id" {
  type        = string
  description = "The Key ID or alias of the AWS KMS Key. It has to be available in the same region and account as the configured provider."
}

variable "okta_configuration" {
  type = object({
    label          = string
    type           = string
    grant_types    = list(string)
    omit_secret    = bool
    response_types = list(string)
    pkce_required  = bool
  })
  description = "Details needed to configure an okta app. Its token auth method is private_key_jwt"
}

variable "friendly_key_identifier" {
  type        = string
  description = "A name for the key configuration in the okta app, something you will recognize for yourself and the project."
}

variable "write_metadata_to_params" {
  type        = bool
  description = <<EOF
  Whether you want to include the clientID and KMS Key Alias grouped together as securestring parameters in JSON format. If true, module will write these details to a path based on the env, project and service"
  They will be written following path:
    /<project>-<env>-<service>/client_id
    /<project>-<env>-<service>/kms_key_id

  (the module may add secrets over time)

  Note that these values should correspond with the consuming service's tagset so secrets are placed in the path they expect.
  EOF
}

variable "tags" {
  type = object({
    project = string,
    env     = string,
    service = string,
    owner   = string,
  })

  description = <<EOF
  These values are used to derive the path in the param store where to write the Okta App Configuration metadata.
  EOF
}

variable "assume_role_name" {
  type        = string
  description = "Name of the role that your Terraform environment can assume."
}