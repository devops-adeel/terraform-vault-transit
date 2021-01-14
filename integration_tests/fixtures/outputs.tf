output "vault_identity_group_encrypt" {
  description = "JSON data of the Vault Identity Group, including list of member entities"
  value       = jsondecode(module.transit.vault_identity_group_encrypt)
}

output "vault_identity_group_decrypt" {
  description = "JSON data of the Vault Identity Group, including list of member entities"
  value       = jsondecode(module.transit.vault_identity_group_decrypt)
}
