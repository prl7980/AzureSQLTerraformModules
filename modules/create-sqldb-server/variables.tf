# SQL Logical Server name and location

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

# Server login details

variable "admin_login" {
  type        = string
  description = "Admin SQL login on logical sql server."
  default     = "DBAdmin"
}

variable "ad_admin_login" {
  type        = string
  description = "Admin AD login on logical sql server."
  default     = "DBAdmins"
}

# Key vault settings

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

# Server Settings

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

variable "tags" {
  description = "The tags for the SQL Logical server."
  type        = map(any)
  default = {
    
  }
}

# Network settings

# Public settings and firewalls

variable "public" {
  type        = string
  description = "Allow public access."
  default     = "false"
}

variable "firewall_rules" {
  description = "List of firewall rules to add to the SQL logical server."
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}

variable "outbound" {
  type        = string
  description = "Allow outbound access."
  default     = "false"
}

# Private endpoint 

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

