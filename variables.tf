variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "resource_group_name" {}
variable "storage_account_name" {}
variable "tfstate_access_key" {}
variable "location" {}
variable "tags" {
  type        = "map"
  description = "tags for the stack"
}

variable "enable_firewall" {
  description = "creates firewall if set to true"
  type        = bool
}
