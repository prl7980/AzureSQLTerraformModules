module "BuildSQLDBServer" {
  source      = "../../AZModules/create-sqldb-server"
  server_name = "prlsqldb3"
  #public = false
  tags = {
    environment = "dev"
    test = "test"
  }
  firewall_rules = [
    {
      name             = "azure-access"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
  },    {
      name             = "me"
      start_ip_address = "174.4.29.173"
      end_ip_address   = "174.4.29.173"
  }
  ]
}

#module "BuildSQLDBServer2" {
#  source      = "../../AZModules/create-sqldb-server"
#  server_name = "prlsqldb2"
#  #public = false
#}


module "BuildBolloxDB" {
  source        = "../../AZModules/create-sqldb-database"
  server_id     = module.BuildSQLDBServer.sql_server_id
  database_name = "Movies"
  #sku           = "GP_S_Gen5_2"
  #serverless_min_cpu = 2
  #serverless_pause = -1
  #zone_redundant = true
}

#module "BuildMoviesDB" {
#  source                 = "../../AZModules/create-sqldb-database-import"
#  server_id              = module.BuildSQLDBServer.sql_server_id
#  database_name          = "Movies"
#  import_resouce_group   = "Storage"
#  import_storage_account = "prl69storage"
#  import_container_name  = "backups"
#  import_bacpac_name     = "Movies.bacpac"
#  #serverless_pause = -1
#  #zone_redundant = true
#}

