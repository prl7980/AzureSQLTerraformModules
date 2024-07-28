#variable "server_name" {
#type        = string
#  description = "Name of the logical SQL server to create the database."
#}

variable "server_id" {
  type        = string
  description = "Name of the logical SQL server to create the database."
}

variable "rg_name" {
  type        = string
  description = "Name of Resource Group for the logical server."
  default     = "SQLDB"
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
  description = "Pause before serverless shutdown in minutes, -1 disabled"
  default     = 60
}

variable "serverless_min_cpu" {
  type        = number
  description = "Minimum CPU capacity"
  default     = 0.5
}

variable "max_data_size" {
  type        = number
  description = "Maximum data size"
  default     = null
}

variable "license_type" {
  type        = string
  description = "Sets the license type to either LicenseIncluded or BasePrice"
  default     = null
}

variable "db_tags" {
  description = "The tags for the SQL Logical server."
  type        = map(any)
  default = {
  }
}

variable "geo_backup_enabled" {
  type        = bool
  description = "Minimum CPU capacity"
  default     = true
}

variable "backup_storage_type" {
  type        = string
  description = ""
  default     = "GEO"
}

variable "zone_redundant" {
  type        = bool
  description = "Minimum CPU capacity"
  default     = false
}

variable "backup_retention" {
  type    = number
  default = 7
}

variable "backup_interval_in_hours" {
  type    = number
  default = 24
}
