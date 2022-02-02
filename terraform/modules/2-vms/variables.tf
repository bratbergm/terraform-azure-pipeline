variable "resource_group_name" {
  type        = string
  default     = ""
}

variable "location" {
  type        = string
  default     = ""
}

variable "subnet_id" {
  type        = string
  default     = ""
}

variable "vm_name" {
  type        = string
  default     = "win-vm-1"
}

variable "vm_size" {
  type        = string
  default     = "Standard_F2"
}