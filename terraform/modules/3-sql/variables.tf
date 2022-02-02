variable "resource_group_name" {
  type        = string
  default     = ""
}

variable "location" {
  type        = string
  default     = ""
}

variable "sql_server_name" {
  type        = string
  default     = "sql-server-1"
}

variable "sql_server_version" {
  type        = string
  default     = "12.0"
}

variable "sql_database_name" {
  type        = string
  default     = "sql-db-1"
}

variable "sql_database_edition" {
  type        = string
  default     = "Basic"
}