## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| `vault` | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `env` | The name of the environment which the key belongs to | `string` | n/a | yes |
| `service_name` | The name of the service consuming the transit key | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| `transit_key_keys` | List of key versiuons in the keyring. |
| `transit_key_latest` | Latest key version available. |
