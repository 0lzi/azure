# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
  tags = { 
     env = "dev"
     project = "az104"
  }
}