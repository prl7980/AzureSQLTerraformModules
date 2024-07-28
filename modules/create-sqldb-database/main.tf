

resource "azurerm_mssql_database" "db" {
  name                        = var.database_name
  server_id                   = var.server_id
  sku_name                    = var.sku
  license_type                = var.license_type
  min_capacity                = substr(var.sku, 0, 4) != "GP_S" ? null : var.serverless_min_cpu
  auto_pause_delay_in_minutes = substr(var.sku, 0, 4) != "GP_S" ? null : var.serverless_pause     
  max_size_gb                 = var.max_data_size
  tags                        = var.db_tags
  zone_redundant              = var.zone_redundant
  short_term_retention_policy {
    retention_days = var.backup_retention
    backup_interval_in_hours = var.backup_interval_in_hours
  }

}