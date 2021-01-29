locals {
  application_name = "terraform-modules-development-transit"
  env              = "dev"
  service          = "web"
}

resource "vault_namespace" "default" {
  path = local.application_name
}

provider "vault" {
  alias     = "default"
  namespace = trimsuffix(vault_namespace.default.id, "/")
}

module "default" {
  source = "./module"
  providers = {
    vault = vault.default
  }
  encrypt_entity_ids = [module.vault_approle.entity_id]
  decrypt_entity_ids = [module.vault_approle.entity_id]
}

resource "vault_auth_backend" "default" {
  provider = vault.default
  type     = "approle"
}

module "vault_approle" {
  source = "git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.6.1"
  providers = {
    vault = vault.default
  }
  application_name = local.application_name
  env              = local.env
  service          = local.service
  mount_accessor   = vault_auth_backend.default.accessor
}

resource "vault_approle_auth_backend_login" "default" {
  provider  = vault.default
  backend   = module.vault_approle.backend_path
  role_id   = module.vault_approle.approle_id
  secret_id = module.vault_approle.approle_secret
}

resource "vault_transit_secret_backend_key" "default" {
  provider         = vault.default
  backend          = module.default.backend_path
  name             = format("%s-%s", local.env, local.service)
  deletion_allowed = true
}

provider "vault" {
  alias     = "transit"
  namespace = trimsuffix(vault_namespace.default.id, "/")
  token     = vault_approle_auth_backend_login.default.client_token
}

data "vault_transit_encrypt" "default" {
  provider  = vault.transit
  backend   = module.default.backend_path
  key       = vault_transit_secret_backend_key.default.name
  plaintext = "devops-adeel"
}

data "vault_transit_decrypt" "default" {
  provider   = vault.transit
  backend    = module.default.backend_path
  key        = vault_transit_secret_backend_key.default.name
  ciphertext = data.vault_transit_encrypt.default.ciphertext
}
