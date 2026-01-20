resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "myaks" 

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    
    vm_size    = "Standard_D2s_v3" 
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}