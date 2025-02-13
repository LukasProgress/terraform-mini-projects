variable "resource_group_name" {
  type = string
  default = "terraform-static-site-lukas"
}

variable "location" {
    type = string
    default = "Germany West Central"
}

variable "storage_account_name" {
    type = string
    default = "lukasstatic12022025"
}

variable "enable_error_page" {
    type = bool
    default = false
}

variable "subscription_id" {
  type = string
  sensitive = true
}