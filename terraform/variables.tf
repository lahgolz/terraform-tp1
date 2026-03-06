variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "tp1"
}

variable "app_env" {
  description = "Application environment (e.g., development, production)"
  type        = string
  default     = "development"
}

variable "api_port" {
  description = "Port for the API service"
  type        = number
  default     = 3000
}

variable "adminer_port" {
  description = "Port for the Adminer service"
  type        = number
  default     = 8080
}

variable "db_user" {
  description = "Database username"
  type        = string
  default     = "user"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = "password"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "mydatabase"
}