variable "resource_group_name" {
  type        = string
  default     = ""
}

variable "location" {
  type        = string
  default     = ""
}

variable "vnet_name" {
  type        = string
  default     = "first_vnet"
}

variable "address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "description"
}

variable "subnet_name" {
  type        = string
  default     = "first_subnet"
  description = "description"
}

variable "environment" {
  type        = string
  default     = ""
}


