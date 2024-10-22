resource "random_password" "postgresql_password" {
  length  = 16
  special = true
}

resource "azurerm_postgresql_server" "postgresql" {
  name                         = "pgserver-${var.name}"
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  administrator_login          = "pgadmin"
  administrator_login_password = random_password.postgresql_password.result
  sku_name                     = "GP_Gen5_2"
  storage_mb                   = 5120
  version                      = "11"
  auto_grow_enabled            = true
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "mydatabase" {
  name                = "${var.name}-db"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = "UTF8"
  collation           = "en_US.UTF8"
}

resource "azurerm_postgresql_firewall_rule" "allow_aks_subnet" {
  name                = "allow_aks_subnet"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgresql.name
  start_ip_address    = "10.0.1.4"
  end_ip_address      = "10.0.1.254"
  depends_on = [azurerm_resource_group.rg, azurerm_subnet.aks_subnet]
}

resource "azurerm_private_endpoint" "postgres" {
  name                = "private-endpoint-postgres"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.aks_subnet.id

  private_service_connection {
    name                           = "postgres-connection"
    private_connection_resource_id = azurerm_postgresql_server.postgresql.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "postgresql-password"
  value        = random_password.postgresql_password.result
  key_vault_id = azurerm_key_vault.keyvault.id
}
