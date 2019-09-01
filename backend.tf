terraform {
  backend "azurerm" { #empty backend, initialize with terraform init --backend-config=FILE
  }
}