provider "azurerm" {
  features {}
}


terraform {
  backend "azurerm" {
    use_oidc             = true                                    # Can also be set via `ARM_USE_OIDC` environment variable.
    use_azuread_auth     = true                                    # Can also be set via `ARM_USE_AZUREAD` environment variable.
    storage_account_name = "terraformproj9948113498"                              # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "terraformproj"                               # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "terraform.tfstate"                # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}


resource "azurerm_resource_group" "example" {
  name     = "demo-resources"
  location = "UK South"
}

resource "azurerm_storage_account" "example" {
  name                     = "bootdemoinfra0099"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
