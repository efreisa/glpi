# GLPI configuration
# Resource Group

locals {
  rg_name = "rg_${var.project}_${var.env}"
  plan_name = "plan-${var.project}-${var.env}-001"
  app_name = "app-${var.project}-${var.env}-001"
}

# GLPI ResourceGroup
resource "azurerm_resource_group" "glpi_demo_rg" {
  name     = local.rg_name
  location = var.location
  tags     = {
    "environment"    = var.env
    "projet"         = var.project
    }
}

# GLPI App Plan
resource "azurerm_app_service_plan" "glpi_demo_app_plan" {
  name                = local.plan_name
  location            = azurerm_resource_group.glpi_demo_rg.location
  resource_group_name = azurerm_resource_group.glpi_demo_rg.name
  kind                = "linux"
  reserved            = true
  
  sku {
    tier = "Basic"
    size = "B1"
  }

  tags = azurerm_resource_group.glpi_demo_rg.tags
}

# GLPI web app
resource "azurerm_app_service" "glpi_demo_app" {
  name                = local.app_name
  location            = azurerm_resource_group.glpi_demo_rg.location
  resource_group_name = azurerm_resource_group.glpi_demo_rg.name
  app_service_plan_id = azurerm_app_service_plan.glpi_demo_app_plan.id
  https_only          = true
}
