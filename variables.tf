variable "service_name" {
  description = "The name of the service consuming the transit key"
  type = string
}

variable "env" {
  description = "The name of the environment which the key belongs to"
  type = string
}
