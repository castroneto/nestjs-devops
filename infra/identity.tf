resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "${var.name}-aks-identity"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}