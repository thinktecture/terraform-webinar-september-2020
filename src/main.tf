locals {
  default_tags = {
    generator = "Terraform"
    app       = "Live Demo"
  }

  all_tags = merge(local.default_tags, var.tags)
}

resource "azurerm_resource_group" "rg" {
  name     = "dev-thh-live-${terraform.workspace}"
  location = var.location
  tags     = local.all_tags
}

resource "azurerm_application_insights" "ai" {
  name                = "ai-webinar-live-${terraform.workspace}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  application_type    = "web"
  tags                = local.all_tags
}

resource "azurerm_app_service_plan" "asp" {
  name                = "asp-webinar-${terraform.workspace}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  kind                = "Linux"
  reserved            = true
  sku {
    tier = var.app_service_plan.tier
    size = var.app_service_plan.size
  }
  tags = local.all_tags
}

resource "azurerm_app_service" "as_demo" {
  name                = "as-webinar-${terraform.workspace}"
  app_service_plan_id = azurerm_app_service_plan.asp.id
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.ai.instrumentation_key
  }
  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|nginx:latest"
  }
  tags = local.all_tags
}
