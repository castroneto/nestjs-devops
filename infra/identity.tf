resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "${var.name}-aks-identity"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}