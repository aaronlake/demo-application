terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.2.0"
    }

    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.22.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.3.1"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = local.common_tags
  }
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

provider "vault" {
  address = data.tfe_outputs.infrastructure.values.vault_public_endpoint_url

  # auth_login {
  #   namespace = "admin"
  #   path      = "auth/userpass/login/${var.login_approle_role_id}"
  # }
}
