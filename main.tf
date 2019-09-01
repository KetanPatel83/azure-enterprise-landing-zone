resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}
module "network" {
  source              = "Azure/network/azurerm"
  vnet_name           = "test-vnet"
  resource_group_name = "${var.resource_group_name}"
  location            = "${azurerm_resource_group.resource_group.location}"
  address_space       = "10.10.0.0/22"
  subnet_prefixes     = ["10.10.1.0/24", "10.10.2.0/23"]
  subnet_names        = ["data", "app"]
  tags                = "${var.tags}"
}

resource "azurerm_subnet" "web-sub" {
  name                 = "web"
  address_prefix       = "10.10.0.0/24"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = module.network.vnet_name
}

resource "azurerm_network_watcher" "watcher" {
  name                = "production-nwwatcher"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  tags                = "${var.tags}"
}
