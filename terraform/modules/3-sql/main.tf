resource "azurerm_sql_server" "sqlserver1" {
  name                 = var.sql_server_name
  resource_group_name  = var.resource_group_name # Or: azurerm_resource_group.resource_group1.name
  location             = var.location
  version              = var.sql_server_version
  administrator_login  = ""
  administrator_login_password = ""
}

resource "azurerm_sql_database" "sqldatabase1" {
  name                 = var.sql_database_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  server_name          = azurerm_sql_server.sqlserver1.name
  edition              = var.sql_database_edition
}