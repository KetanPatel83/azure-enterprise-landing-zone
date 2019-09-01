variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "resource_group_name" {}
variable "location" {}
variable "tags" {
  type        = "map"
  description = "tags for the stack"
}
