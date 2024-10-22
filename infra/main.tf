provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }

  }
  subscription_id = var.subscription
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.name}-infra"
  location = var.location
}

