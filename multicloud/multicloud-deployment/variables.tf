variable "aws_region" {
  type = string
  default = "eu-central-1"
}

variable "azure_region" {
  type = string
  default = "West Europe"
}

variable "subscription_id" {
    type = string
    sensitive = true
}
