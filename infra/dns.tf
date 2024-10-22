
resource "azurerm_private_dns_zone" "example" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = data.azurerm_resource_group.rg.name
}


resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "dns-link"
  resource_group_name   = data.azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  private_dns_zone_name = azurerm_private_dns_zone.example.name
}

resource "azurerm_private_dns_a_record" "example" {
  name                = azurerm_postgresql_server.postgresql.name
  zone_name           = azurerm_private_dns_zone.example.name
  resource_group_name = data.azurerm_resource_group.rg.name
  records             = [azurerm_private_endpoint.postgres.private_service_connection[0].private_ip_address]
  ttl                 = 300
}