resource "azurerm_resource_group" "rg1" {
  name     = "rg_dev"
  location = "eastus"
}

resource "azurerm_resource_group" "rg2" {
  name     = "rg_test"
  location = "westus"
}

resource "azurerm_resource_group" "rg3" {
  name     = "rg_prod"
  location = "centralus"
}

resource "azurerm_storage_account" "sa1" {
  name                     = "stgadevstorage"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "sa2" {
  depends_on               = [azurerm_resource_group.rg2]
  name                     = "stgateststorage"
  resource_group_name      = "rg_test"
  location                 = "westus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "sa3" {
  depends_on               = [azurerm_resource_group.rg3]
  name                     = "stg1prodstorage"
  resource_group_name      = "rg_prod"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "container1" {
  name                  = "devcontainer"
  storage_account_name  = azurerm_storage_account.sa1.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "container2" {
  depends_on            = [azurerm_storage_account.sa2]
  name                  = "testcontainer"
  storage_account_name  = "stgateststorage"
  container_access_type = "blob"
}

resource "azurerm_storage_container" "container3" {
  name                  = "prodcontainer"
  storage_account_name  = azurerm_storage_account.sa3.name
  container_access_type = "blob"
}