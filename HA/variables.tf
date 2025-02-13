variable "resource_group_name" {
    type = string
    default = "rg-24-04-on-lukas-probst"
}

variable "subscription_id" {
    type = string
    sensitive = true
}

variable "location" {
    type = string
    default = "West Europe"
}

variable "storage_account_name" {
    type = string
    default = "lukaswebsite"
}

variable "index_document" {
    type = string
    default = "index.html"
}

variable "error_document" {
    type = string
    default = "error.html"
}

variable "enable_error_page" {
    type = bool 
}