output "sql_server_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure SQL Database created."
  value       = module.BuildSQLDBServer1.sql_server_fqdn
}

output "sql_server_id" {
  description = "Microsoft SQL Server ID."
  value       = module.BuildSQLDBServer1.sql_server_id
}

#output "sql_admin_password" {
#  value       = "${module.BuildSQLDBServer.sql_admin_password}"
#  sensitive   = true
#}
