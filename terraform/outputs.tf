output "api_url" {
  description = "Base URL of the API"
  value       = "http://localhost:${var.api_port}"
}

output "adminer_url" {
  description = "URL of the Adminer web interface"
  value       = "http://localhost:${var.adminer_port}"
}

output "db_dsn" {
  description = "PostgreSQL connection string"
  value       = "postgresql://${var.db_user}:${var.db_password}@localhost:5432/${var.db_name}"
  sensitive   = true
}
