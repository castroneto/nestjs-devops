resource "local_file" "k8s_secret" {
  content  = templatefile("${path.module}/templates/deployment.tpl", {
    name = var.name,
    identity_client_id    = azurerm_user_assigned_identity.aks_identity.client_id,
    db_password           = random_password.postgresql_password.result,
    db_username           = azurerm_postgresql_server.postgresql.administrator_login,
    db_server             = azurerm_private_dns_a_record.example.fqdn,
    db_name               = azurerm_postgresql_database.mydatabase.name,
    key_vault_name        = azurerm_key_vault.keyvault.name,
    key_vault_secret_name = azurerm_key_vault_secret.db_password.name
  })
  filename = "${path.module}/../k8s/deployment.yaml"
}
resource "local_file" "ci_cd_deploy" {
  content = templatefile("${path.module}/templates/deploy.tpl", {
    name = var.name,
    acr_name           = azurerm_container_registry.acr.name
    resource_group_name = data.azurerm_resource_group.rg.name
    aks_cluster_name   = azurerm_kubernetes_cluster.aks.name
  })
  filename = "${path.module}/../.github/workflows/deploy.yml"
}
resource "local_file" "hpa" {
  content = templatefile("${path.module}/templates/hpa.tpl", {
    name = var.name
  })
  filename = "${path.module}/../k8s/hpa.yaml"
}
resource "local_file" "service" {
  content = templatefile("${path.module}/templates/service.tpl", {
    name = var.name
  })
  filename = "${path.module}/../k8s/service.yaml"
}