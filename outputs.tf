output "transit_key_keys" {
  description = "List of key versiuons in the keyring."
  value       = vault_transit_secret_backend_key.default.keys
}

output "transit_key_latest" {
  description = "Latest key version available."
  value       = vault_transit_secret_backend_key.default.latest_version
}
