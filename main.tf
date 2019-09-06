resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}
module "network" {
  source              = "Azure/network/azurerm"
  vnet_name           = "hub-vnet"
  resource_group_name = "${var.resource_group_name}"
  location            = "${azurerm_resource_group.resource_group.location}"
  address_space       = "10.10.0.0/22"
  subnet_prefixes     = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  subnet_names        = ["AzureFirewallSubnet", "web", "app", "data"]
  tags                = "${var.tags}"
}

resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  address_prefix       = "10.10.0.0/24"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = module.network.vnet_name
}

resource "azurerm_subnet" "web-sub" {
  name                 = "web"
  address_prefix       = "10.10.1.0/24"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = module.network.vnet_name
}

resource "azurerm_network_watcher" "watcher" {
  name                = "production-nwwatcher"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  tags                = "${var.tags}"
}

module "spoke-1" {
  source              = "Azure/network/azurerm"
  vnet_name           = "spoke-vnet-1"
  resource_group_name = "${var.resource_group_name}"
  location            = "${azurerm_resource_group.resource_group.location}"
  address_space       = "10.11.0.0/22"
  subnet_prefixes     = ["10.11.0.0/23", "10.11.2.0/23"]
  subnet_names        = ["web-spoke-1", "app-spoke-1"]
  tags                = "${var.tags}"
}

module "spoke-2" {
  source              = "Azure/network/azurerm"
  vnet_name           = "spoke-vnet-2"
  resource_group_name = "${var.resource_group_name}"
  location            = "${azurerm_resource_group.resource_group.location}"
  address_space       = "10.12.0.0/22"
  subnet_prefixes     = ["10.12.0.0/23", "10.12.2.0/23"]
  subnet_names        = ["web-spoke-2", "app-spoke-2"]
  tags                = "${var.tags}"
}

resource "azurerm_virtual_network_peering" "spoke-1" {
  name                      = "spoke1tohub"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${module.spoke-1.vnet_name}"
  remote_virtual_network_id = "${module.network.vnet_id}"
}

resource "azurerm_virtual_network_peering" "spoke-2" {
  name                      = "spoke2tohub"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${module.spoke-2.vnet_name}"
  remote_virtual_network_id = "${module.network.vnet_id}"
}