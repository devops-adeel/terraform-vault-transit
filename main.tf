resource "vault_transit_secret_backend_key" "default" {
  backend                = "transit"
  name                   = "${var.env}-${var.service_name}"
  type                   = "rsa-4096"
  deletion_allowed       = true
  allow_plaintext_backup = true
}
