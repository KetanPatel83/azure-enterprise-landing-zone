resource "random_id" "uniqueString" {
  keepers = {
    uniqueid = "app"
  }
  byte_length = 6
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}
resource "azurerm_storage_account" "tf_backend" {
  name                     = "tfbackend${random_id.uniqueString.hex}"
  resource_group_name      = "${azurerm_resource_group.resource_group.name}"
  location                 = "${var.location}"
  account_tier             = "standard"
  account_replication_type = "LRS"
  tags                     = "${var.tags}"
  lifecycle {
    prevent_destroy = false
  }
}
resource "azurerm_storage_container" "tf_state_lock" {
  name                  = "tfstatelock${random_id.uniqueString.hex}"
  storage_account_name  = "${azurerm_storage_account.tf_backend.name}"
  container_access_type = "private"
  lifecycle {
    prevent_destroy = false
  }
}