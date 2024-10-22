resource "azurerm_kubernetes_cluster" "aks" {
  name                      = "aks-cluster"
  location                  = data.azurerm_resource_group.rg.location
  resource_group_name       = data.azurerm_resource_group.rg.name
  dns_prefix                = "myakscluster"
  workload_identity_enabled = true
  oidc_issuer_enabled       = true

  default_node_pool {
    name                   = "default"
    vm_size                = "Standard_B2ms" # Mantendo Standard_B2ms
    min_count              = 1               # Número mínimo de nós
    max_count              = 5               # Escalonamento automático para até 5 nós
    auto_scaling_enabled   = true            # Habilitar autoescalonamento    vm_size    = "Standard_B2ms"
    vnet_subnet_id         = azurerm_subnet.aks_subnet.id
    node_public_ip_enabled = false
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.0.3.0/24"
    dns_service_ip = "10.0.3.10"
  }

  depends_on = [data.azurerm_resource_group.rg, azurerm_subnet.aks_subnet]
}
