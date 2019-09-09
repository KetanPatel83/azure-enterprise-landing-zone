resource "azurerm_virtual_network_peering" "spoke-1" {
  name                      = "spoke1tohub"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${module.spoke-1.vnet_name}"
  remote_virtual_network_id = "${module.network.vnet_id}"
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "spoke-2" {
  name                      = "spoke2tohub"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${module.spoke-2.vnet_name}"
  remote_virtual_network_id = "${module.network.vnet_id}"
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "hub-spoke1" {
  name                      = "hubtospoke1"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${module.network.vnet_name}"
  remote_virtual_network_id = "${module.spoke-1.vnet_id}"
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "hub-spoke2" {
  name                      = "hubtospoke2"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${module.network.vnet_name}"
  remote_virtual_network_id = "${module.spoke-2.vnet_id}"
  allow_forwarded_traffic   = true
}