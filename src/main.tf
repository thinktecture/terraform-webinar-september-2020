terraform {
  required_version = ">= 0.13.0"
  required_providers {
    azurerm = "~> 2.26.0"
  }

  backend "azurerm" {
    resource_group_name  = "dev-thh"
    storage_account_name = "tfwebinar"
    container_name       = "tfwebinar"
    key                  = "live.tfstate"
    environment          = "public"
    # access_key is read from ARM_ACCESS_KEY environment variable
  }
}
provider "azurerm" {
  features {}
}
