terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
  }
  backend "remote" {
    organization = "example-org"

    workspaces {
      name = local.application_name
    }
  }
}

provider "vault" {
  address = "https://127.0.0.1:8200"
}

locals {
  application_name = "example-application"
}

resource "vault_namespace" "default" {
  path = local.application_name
}

provider "vault" {
  alias     = "default"
  namespace = trimsuffix(vault_namespace.default.id, "/")
}

module "transit" {
  source = "git::https://github.com/devops-adeel/terraform-vault-transit.git?ref=v0.2.0"
  providers = {
    vault = vault.default
  }
  decrypt_group_ids = [module.vault_approle.group_id]
  encrypt_group_ids = [module.vault_approle.group_id]
}

module "vault_approle" {
  source = "git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.4.0"
  providers = {
    vault = vault.default
  }
  application_name = local.application_name
  env              = "dev"
  service          = "web"
}
