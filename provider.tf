terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "5f47120f-5da4-4214-bd2a-ec352c3ba4bf"
}