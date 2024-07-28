variable "server_name" {
  type        = string
  description = "Name of the logical SQL server."
}

variable "region_location" {
  type        = string
  description = "Region of Logical server."
}

variable "rg_name" {
  type        = string
  description = "Name of Resource Group."
}

variable "admin_login" {
  type        = string
  description = "Admin SQL login on logical sql server."
  default     = "DBAdmin"
}

variable "kv_name" {
  type        = string
  description = "Name of keyvault to add password for master account."
  default     = "databasekv"
}

variable "kv_rg" {
  type        = string
  description = "Resource group of the kKey Vault."
  default     = "SQLDB"
}


variable "public" {
  type        = string
  description = "Allow public access."
  default     = "true"
}

variable "outbound" {
  type        = string
  description = "Allow outbound access."
  default     = "false"
}

variable "server_version" {
  type        = string
  description = "Server version."
  default     = "12.0"
}

variable "min_tls_version" {
  type        = string
  description = "Minimum version of TLS allowed."
  default     = "1.2"
}

variable "firewall_rules" {
  description = "List of firewall rules to add to the SQL logical server."
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
  #default = [
  #{
  #  name              = "1"
  #  start_ip_address  = "174.4.29.173"
  #  end_ip_address    = "174.4.29.173"
  #}]
}

variable "tags" {
  description = "The tags for the SQL Logical server."
  type        = map(any)
  default = {
    
  }
}

variable "create_db" {
  type = bool
  description = "Option to create a blank database."
  default = false  
}

variable "database_name" {
  type        = string
  description = "Name of database"
  default     = "SQLDB"
}

variable "sku" {
  type        = string
  description = "Sku of database insance"
  default     = "GP_S_Gen5_1"
}

variable "serverless_pause" {
  type        = number
  description = "Pause before serverless shutdown in minutes"
  default     = 60
}

variable "serverless_min_cpu" {
  type        = number
  description = "Minimum CPU capacity"
  default     = 0.5
}

variable "db_tags" {
  description = "The tags for the SQL Logical server."
  type        = map(any)
  default = {
  }
}

variable "create_pri_endpoint" {
  type = bool
  description = "Option to create a private endpoint."
  default = true 
}

variable "vn_name" {
  type        = string
  description = "Name of vnet where to put private endpoint."
  default     = "main"
}

variable "vn_subnet" {
  type        = string
  description = "Name of subnet where to put private endpoint."
  default     = "db"
}

variable "vn_rg" {
  type        = string
  description = "Location of rg of vnet subnet."
  default     = "SQLVM"
}

