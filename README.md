## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| `vault` | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `decrypt_entity_ids` | List of Vault Identity Entity IDs to be a member of Vault Identity Group for decrypting Transit keys | `list` | `[]` | no |
| `encrypt_entity_ids` | List of Vault Identity Entity IDs to be a member of Vault Identity Group for encrypting Transit keys | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| `vault_identity_group_decrypt` | JSON data of the Vault Identity Group, including list of member entities |
| `vault_identity_group_encrypt` | JSON data of the Vault Identity Group, including list of member entities |
