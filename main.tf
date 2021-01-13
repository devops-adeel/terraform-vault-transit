locals {
  encrypt_member_group_ids = var.encrypt_group_ids != [] ? var.encrypt_group_ids : [vault_identity_group.placeholder.id]
  decrypt_member_group_ids = var.decrypt_group_ids != [] ? var.decrypt_group_ids : [vault_identity_group.placeholder.id]
}

resource "vault_mount" "default" {
  path        = "transit"
  type        = "transit"
  description = "Vault Secret mount for Transit engine"
}

data "vault_policy_document" "encrypt" {
  rule {
    path         = "transit/encrypt/{{identity.entity.metadata.env}}-{{identity.entity.metadata.service}}"
    capabilities = ["update"]
    description  = "Allow the use of encryption action with the transit key"
  }
}

data "vault_policy_document" "decrypt" {
  rule {
    path         = "transit/decrypt/{{identity.entity.metadata.env}}-{{identity.entity.metadata.service}}"
    capabilities = ["update"]
    description  = "Allow the use of decryption action with the transit key"
  }
}

resource "vault_policy" "encrypt" {
  name   = "transit-encrypt-tmpl"
  policy = data.vault_policy_document.encrypt.hcl
}

resource "vault_policy" "decrypt" {
  name   = "transit-decrypt-tmpl"
  policy = data.vault_policy_document.decrypt.hcl
}

resource "vault_identity_group" "encrypt" {
  name             = "transit-encrypt"
  type             = "internal"
  member_group_ids = local.encrypt_member_group_ids
  policies         = ["default", vault_policy.encrypt.name]
}

resource "vault_identity_group" "decrypt" {
  name             = "transit-decrypt"
  type             = "internal"
  member_group_ids = local.decrypt_member_group_ids
  policies         = ["default", vault_policy.decrypt.name]
}

resource "vault_identity_group" "placeholder" {
  name = "default"
}

data "vault_identity_group" "encrypt" {
  group_id = vault_identity_group.encrypt.id
}

data "vault_identity_group" "decrypt" {
  group_id = vault_identity_group.decrypt.id
}
