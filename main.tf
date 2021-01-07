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
  name   = "transit-encrypt"
  policy = data.vault_policy_document.encrypt.hcl
}

resource "vault_policy" "decrypt" {
  name   = "transit-decrypt"
  policy = data.vault_policy_document.decrypt.hcl
}

resource "vault_identity_group" "encrypt" {
  name              = "transit-encrypt"
  type              = "internal"
  member_entity_ids = var.entity_ids != [] ? var.entity_ids : [vault_identity_entity.default.id]
  policies = ["default", vault_policy.encrypt.name]
}

resource "vault_identity_group" "decrypt" {
  name              = "transit-decrypt"
  type              = "internal"
  member_entity_ids = var.entity_ids != [] ? var.entity_ids : [vault_identity_entity.default.id]
  policies = ["default", vault_policy.decrypt.name]
}
