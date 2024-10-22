resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.name}-log-analytics"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"  # O SKU padrão para o Log Analytics
  retention_in_days   = 30           # Quantidade de dias para manter os logs
}

resource "azurerm_monitor_diagnostic_setting" "aks_monitoring" {
  name               = "aks-monitoring"
  target_resource_id = azurerm_kubernetes_cluster.aks.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category = "kube-apiserver"
  }

  metric {
    category = "AllMetrics"
  }
}