# Aufgabe: Terraform-Template für statisches Website-Hosting auf Azure
# Erstelle ein Terraform-Template, das eine statische Website auf Azure hostet. 
# Verwende dazu einen Azure Storage Account mit aktiviertem Static Website Hosting.

# Anforderungen: Bereitstellung eines Azure Storage Accounts mit den erforderlichen Einstellungen für 
# statisches Website-Hosting. Hochladen einer Beispiel-HTML-Datei (z. B. index.html) als Startseite der Website. 
# Konfiguration der Zugriffsrechte, sodass die Website öffentlich erreichbar ist. 
# Als Terraform-Output soll der öffentliche URL-Link zur gehosteten Website ausgegeben werden.

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_storage_account" "storage" {
    name                    = var.storage_account_name
    resource_group_name     = var.resource_group_name
    location                = var.location
    account_tier            = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_storage_account_static_website" "website" {
    storage_account_id = azurerm_storage_account.storage.id
    index_document = var.index_document
    error_404_document = var.error_document
}

resource "azurerm_storage_blob" "index" {
    name = var.index_document
    storage_account_name = azurerm_storage_account.storage.name
    storage_container_name = "$web"
    type = "Block"
    source = "./files/index.html"
    content_type = "text/html"
    depends_on = [ azurerm_storage_account_static_website.website ]
}

resource "azurerm_storage_blob" "error" {
    # Bedingung: Falls boolean nicht gesetzt, resource 0 mal anlegen
    count = var.enable_error_page ? 1 : 0

    name = var.error_document
    storage_account_name = azurerm_storage_account.storage.name
    storage_container_name = "$web"
    type = "Block"
    source = "./files/error.html"
    content_type = "text/html"
    depends_on = [ azurerm_storage_account_static_website.website ]
}

output "website_url" {
    value = azurerm_storage_account.storage.primary_web_endpoint
}