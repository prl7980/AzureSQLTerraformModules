# *** logic for sql and ad password, uses keyvault ***

locals {
  sql_admin_password = random_password.admin_password.result
}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.kv_rg
}

data "azuread_group" "entra_group" {
  display_name     = var.ad_admin_login
}

resource "random_password" "admin_password" {
  special          = false # set this to false as some command linetools don't like the special characters, your choice to add
  override_special = "#$%-_+{}:"
  upper            = true
  lower            = true
  numeric          = true
  length           = 40
}

resource "azurerm_key_vault_secret" "add_secret" {
  name         = "sqldb-${var.server_name}" # create your own format for secret name
  value        = local.sql_admin_password
  key_vault_id = data.azurerm_key_vault.kv.id
  lifecycle {
    ignore_changes = [value]
  }
}

# *** Build logical server ***

resource "azurerm_mssql_server" "server" {
  name                                 = var.server_name
  resource_group_name                  = var.rg_name
  location                             = var.region_location
  administrator_login                  = var.admin_login
  administrator_login_password         = local.sql_admin_password
  version                              = var.server_version
  minimum_tls_version                  = var.min_tls_version
  public_network_access_enabled        = var.public
  outbound_network_restriction_enabled = var.outbound
  tags                                 = var.tags
  
  azuread_administrator {
    azuread_authentication_only = false
    login_username              = "DBAdminsAD"
    object_id                   = data.azuread_group.entra_group.id
  }
}

# *** Set defender config ***

resource "azurerm_mssql_server_security_alert_policy" "defender" {
  resource_group_name        = var.rg_name
  server_name                = azurerm_mssql_server.server.name 
  state                      = "Enabled"
}

# This is added as I create an express version of defender, and the offical defender module does not account for express
resource "azapi_update_resource" "defender" {
  type = "Microsoft.Sql/servers/sqlVulnerabilityAssessments@2022-05-01-preview"
  name = "default"
  parent_id = azurerm_mssql_server.server.id
  body = jsonencode({
    properties = {
      state = "Enabled"
    }
  })
}

# *** Add firewall rule, assumes public is set to true ****

resource "azurerm_mssql_firewall_rule" "firewall" {
  for_each         = { for idx, rule in var.firewall_rules : idx => rule if var.public }
  name             = "fw-rule-${each.value.name}"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

# *** Private endpoint settings ***

data "azurerm_virtual_network" "vm_network" {
  count               = var.create_pri_endpoint ? 1 : 0
  name                = var.vn_name
  resource_group_name = var.vn_rg
}

data "azurerm_subnet" "vm_network_subnet" {
  count                = var.create_pri_endpoint ? 1 : 0
  name                 = var.vn_subnet
  resource_group_name  = var.vn_rg
  virtual_network_name = data.azurerm_virtual_network.vm_network[0].name
}

resource "azurerm_private_endpoint" "private_endpoint" {
  count               = var.create_pri_endpoint ? 1 : 0
  name                = "${var.server_name}-endpoint"
  location            = var.region_location
  resource_group_name = var.rg_name
  subnet_id           = data.azurerm_subnet.vm_network_subnet[0].id
  tags                = var.tags

  private_service_connection {
    name                           = "${var.server_name}-privateserviceconnection" # Set a name to your standards
    private_connection_resource_id = azurerm_mssql_server.server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dns_zone.id]
  }

}

# Dns Zone details

data "azurerm_private_dns_zone" "dns_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg_name
}
