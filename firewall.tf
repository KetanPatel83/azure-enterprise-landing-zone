resource "azurerm_public_ip" "firewall_ip" {
  #count = var.enable_firewall ? 1 : 0

  name                = "fwpip"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = "${var.tags}"
}
resource "azurerm_firewall" "firewall" {
  count = var.enable_firewall ? 1 : 0

  name                = "webfirewall"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = "${azurerm_subnet.firewall_subnet.id}"
    public_ip_address_id = "${azurerm_public_ip.firewall_ip.id}"
  }
  tags = "${var.tags}"
}