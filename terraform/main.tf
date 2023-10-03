terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
## Optional s3 backend for tfsate file
#  backend "s3" {
#    bucket = "terraform"
#    key    = "tfstates/terraform.tfstate"
#    # next two options needed as we're not using AWS
#    skip_credentials_validation = true
#    force_path_style            = true
#  }
#}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  tenant_id = var.ARM_TENANT_ID
}