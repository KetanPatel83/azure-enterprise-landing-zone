resource "azurerm_availability_set" "web" {
  name                = "web-availability-set"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  managed             = true
  tags                = "${var.tags}"
}

resource "azurerm_availability_set" "app" {
  name                = "app-availability-set"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  managed             = true
  tags                = "${var.tags}"
}

resource "azurerm_availability_set" "data" {
  name                = "data-availability-set"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  managed             = true
  tags                = "${var.tags}"
}