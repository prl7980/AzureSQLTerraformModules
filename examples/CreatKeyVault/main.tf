provider "azurerm" {
  features {
    key_vault {
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets          = true
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "example" {
  name                       = "databasekv"
  location                   = "canadacentral"
  resource_group_name        = "SQLDB"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]
  }
}

#resource "azurerm_key_vault_secret" "example" {
#  name         = "dbadmin"
#  value        = "acrappassword"
#  key_vault_id = azurerm_key_vault.example.id
#}
