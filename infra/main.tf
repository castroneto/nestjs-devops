provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }

  }
  subscription_id = var.subscription
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group
}