resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

//module "kubernetes" {
//  source = "./modules/kubernetes"

//  resource_group_name = azurerm_resource_group.main.name
//  location            = azurerm_resource_group.main.location
  
//  node_count          = 1 
//}

//output "kube_config" {
//  value     = module.kubernetes.kube_config
//  sensitive = true
//}

module "network" {
  source = "./modules/network"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

module "compute" {
  source = "./modules/compute"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vm_size             = var.vm_size
  nic_id              = module.network.nic_id 

  ssh_public_key      = var.ssh_public_key
}

output "vm_public_ip" {
  value = module.network.public_ip
}