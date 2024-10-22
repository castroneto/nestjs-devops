# Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                = "${var.name}acr"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }
}

# Atribuir Permissão para AKS puxar imagens do ACR
#resource "azurerm_role_assignment" "aks_acr_binding" {
#  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
#  role_definition_name = "AcrPull"
#  scope                = azurerm_container_registry.acr.id
#  depends_on           = [azurerm_kubernetes_cluster.aks, azurerm_container_registry.acr]
#}

resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

