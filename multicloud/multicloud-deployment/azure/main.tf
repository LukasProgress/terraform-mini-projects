resource "azurerm_storage_account" "storage" {
  name                     = "tfmulticloudstorage"
  resource_group_name      = var.azure_rg_name
  location                 = var.azure_region
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "terraform-state"
  storage_account_id  = azurerm_storage_account.storage.id
  container_access_type = "private"
}
