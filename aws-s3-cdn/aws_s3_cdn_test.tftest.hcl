variables {
  bucket_name = "cztack-ci-s3-cdn-test"
  region      = "us-west-2"
  project     = "cztack"
  env         = "test"
  service     = "ci"
  owner       = "infra-eng@chanzuckerberg.com"
}

run "private_only_plan" {
  command = plan

  variables {
    delivery = "none"
  }

  assert {
    condition     = module.bucket.name == "cztack-ci-s3-cdn-test"
    error_message = "bucket name did not match expected"
  }

  assert {
    condition     = length(aws_cloudfront_distribution.this) == 0
    error_message = "no distribution should be created for delivery=none"
  }
}

run "cloudfront_geofence_plan" {
  command = plan

  variables {
    delivery = "cloudfront"
  }

  assert {
    condition     = length(aws_cloudfront_distribution.this) == 1
    error_message = "a distribution should be created for delivery=cloudfront"
  }

  assert {
    condition     = aws_cloudfront_distribution.this[0].restrictions[0].geo_restriction[0].restriction_type == "blacklist"
    error_message = "geofence should default to a blacklist"
  }

  assert {
    condition     = contains(aws_cloudfront_distribution.this[0].restrictions[0].geo_restriction[0].locations, "KP")
    error_message = "default sanctioned-country list was not applied"
  }

  assert {
    condition     = aws_cloudfront_origin_access_control.this[0].name == "cztack-ci-s3-cdn-test-oac"
    error_message = "OAC name did not match the expected default"
  }
}

run "boto_reader_plan" {
  command = plan

  variables {
    delivery = "none"
    boto = {
      role_name = "cztack-ci-reader"
      trusts = [{
        oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.us-west-2.amazonaws.com/id/EXAMPLE"
        oidc_issuer_url   = "https://oidc.eks.us-west-2.amazonaws.com/id/EXAMPLE"
        namespace         = "example-ns"
        service_account   = "example-sa"
      }]
    }
  }

  assert {
    condition     = aws_iam_role.boto[0].name == "cztack-ci-reader"
    error_message = "boto role name did not match expected"
  }
}
