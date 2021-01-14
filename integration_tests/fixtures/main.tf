locals {
  application_name = "terraform-modules-development-transit"
}

resource "vault_namespace" "default" {
  path = local.application_name
}

provider "vault" {
  alias     = "default"
  namespace = trimsuffix(vault_namespace.default.id, "/")
}

module "transit" {
  source = "./module"
  providers = {
    vault = vault.default
  }
  /* decrypt_group_ids = [module.vault_approle.group_id] */
  /* encrypt_group_ids = [module.vault_approle.group_id] */
}

module "vault_approle" {
  source = "git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.4.1"
  providers = {
    vault = vault.default
  }
  application_name = local.application_name
  env              = "dev"
  service          = "web"
}
