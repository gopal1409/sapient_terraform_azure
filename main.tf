#terraform init to do the same we will create provider block., 
#infrastructure as code do not change frequently
#when we do terrafomr init it need to download all the plugins required to run deploy your application in the cloud
##create a provider block which contains 
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
