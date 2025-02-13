provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}
resource "azurerm_storage_account_static_website" "website" {
  storage_account_id = azurerm_storage_account.storage.id
  index_document = "index.html"
  error_404_document = var.enable_error_page ? "404.html" : null
}

resource "azurerm_storage_blob" "index" {
  name = "index.html"
  storage_account_name = azurerm_storage_account.storage.name
  storage_container_name = "$web"
  type = "Block"
  source = "./files/index.html"
  content_type = "text/html"
  depends_on = [ azurerm_storage_account_static_website.website ]
}

resource "azurerm_storage_blob" "error_page" {
  count = var.enable_error_page ? 1 : 0
  name = "404.html"
  storage_account_name = azurerm_storage_account.storage.name
  storage_container_name = "$web"
  type = "Block"
  source = "./files/404.html"
  content_type = "text/html"
  depends_on = [ azurerm_storage_account_static_website.website ]

}

output "website_url" {
  value = azurerm_storage_account.storage.primary_web_endpoint
}