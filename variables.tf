variable "encrypt_group_ids" {
  description = "List of Vault Identity Group IDs to be a member of Vault Identity Group for encrypting Transit keys"
  type        = list(any)
  default     = []
}

variable "decrypt_group_ids" {
  description = "List of Vault Identity Group IDs to be a member of Vault Identity Group for decrypting Transit keys"
  type        = list(any)
  default     = []
}
