# Terraform Vault Transit Backend

This terraform module mounts Vault Transit engine, creates a templated ACL policy with an Identity Group associated.

## Status
![terraform-plan-approve-apply](https://github.com/devops-adeel/terraform-vault-transit/workflows/terraform-plan-approve-apply/badge.svg?branch=main)

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| `vault` | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `decrypt_group_ids` | List of Vault Identity Group IDs to be a member of Vault Identity Group for decrypting Transit keys | `list(any)` | `[]` | no |
| `encrypt_group_ids` | List of Vault Identity Group IDs to be a member of Vault Identity Group for encrypting Transit keys | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| `vault_identity_group_decrypt` | JSON data of the Vault Identity Group, including list of member entities |
| `vault_identity_group_encrypt` | JSON data of the Vault Identity Group, including list of member entities |
