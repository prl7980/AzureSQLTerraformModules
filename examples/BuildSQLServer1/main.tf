module "BuildSQLDBServer1" {
  source          = "../../modules/create-sqldb-server"
  server_name     = "testtfdb1"
  region_location = "canadacentral"
  rg_name         = "SQLDB"
  tags = {
    environment = "dev"
  }
  firewall_rules = [
    {
      name             = "azure-access"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  ]
}

#module "BuildDB" {
#  source        = "../../modules/create-sqldb-database"
#  server_id     = module.BuildSQLDBServer1.sql_server_id
#  database_name = "TestDB1"
#  #sku           = "GP_S_Gen5_2"
#  #serverless_min_cpu = 2
#  #serverless_pause = -1
#  #zone_redundant = true
#}
