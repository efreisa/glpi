# Set providers
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

# Configure the Microsoft Azure Active Directory Provider
provider "azuread" {
}

# Configure the Microsoft Azure Resource Manager Provider
provider "azurerm" {
  features {}
}