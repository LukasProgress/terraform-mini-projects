provider "aws" {
  region = "eu-central-1"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

terraform {
  backend "s3" {
    bucket = "lukas-multicloud-backend-1302"
    key = "multicloud-backend/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
  }
}

module "aws_infra" {
  source = "./aws"
  aws_region = var.aws_region
}

module "azure_infra" {
  source = "./azure"
  azure_region = var.azure_region
}