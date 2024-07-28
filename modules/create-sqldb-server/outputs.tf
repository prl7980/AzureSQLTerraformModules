output "sql_server_fqdn" {
  description = "Server name of the Azure SQL Database created."
  value       = "${azurerm_mssql_server.server.fully_qualified_domain_name}"
}

output "sql_server_name" {
  description = "Server name of the Azure SQL Database created."
  value       = "${azurerm_mssql_server.server.name}"
}

output "sql_server_id" {
  description = "Microsoft SQL Server ID."
  value       = "${azurerm_mssql_server.server.id}"
}

#output "sql_admin_password" {
#  description = "SQL Admin passwords automatically generated."
#  value       = local.sql_admin_password
#}

