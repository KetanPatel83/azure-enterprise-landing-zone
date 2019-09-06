resource "azurerm_network_security_group" "web" {
  depends_on          = ["azurerm_subnet.web-sub"]
  name                = "web"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${var.resource_group_name}"

  security_rule {
    name                       = "allow_http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = "${var.tags}"
}

resource "azurerm_subnet_network_security_group_association" "web" {
  depends_on                = ["module.network"]
  subnet_id                 = "${azurerm_subnet.web-sub.id}"
  network_security_group_id = "${azurerm_network_security_group.web.id}"
}

resource "azurerm_public_ip" "firewall_ip" {
  name                = "fwpip"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = "${var.tags}"
}
resource "azurerm_firewall" "firewall" {
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