terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 5.99"
      configuration_aliases = [aws.us-east-1]
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 1.0"
    }
  }
  required_version = "~> 1.9"
}