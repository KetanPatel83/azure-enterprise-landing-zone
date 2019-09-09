output "vnet_id" {
  value = "${module.network.vnet_id}"
}

output "vnet_resource_group_name" {
  value = "${var.resource_group_name}"
}

output "vnet_name" {
  value = "${module.network.vnet_name}"
}
