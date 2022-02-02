variable "environment" {
  type          = string
  default       = ""
}

variable "resource_group_name" {
  type          = string
  default       = "resource_group"
  description   = "Name of the resource group."
}

variable "location" {
  default = "norwayeast"
  description   = "Location of the resources"
}




variable "resource_groups_alert_scope" {
  type = map(object({
    name      = string
    location  = string
    id        = string
  }))
  default = {
    rg = {
      name      = "resource_group1"
      location  = "norwayeast"
      id        = "/subscriptions/0dc3c519-9a44-4b5b-af52-f9027f6f9a1c/resourceGroups/resource_group1"
    },
    rg2 = {
      name      = "resource_group2"
      location  = "norwayeast"
      id        = "/subscriptions/0dc3c519-9a44-4b5b-af52-f9027f6f9a1c/resourceGroups/resource_group2"
    }
  } 
}