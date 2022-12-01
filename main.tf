
variable "location" {
  type    = string
  default = "eastus"
}
variable "tags" {
  type = map(any)
}
locals {
  rg_name = format("tfl-rm-%s-%s", terraform.workspace, random_pet.name.id)
  kv_name = format("tfl-kv-%s1", terraform.workspace)
}

resource "random_pet" "name" {

}
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}
output "rg_name" {
  value = "RG name is %{if terraform.workspace == "default"}|DEFAULT|%{else}|${terraform.workspace}|%{endif} - ${azurerm_resource_group.rg.name}"
}
output "terraform_workspace" {
  value = terraform.workspace
}