provider "docker" {}

resource "docker_network" "app" {
  name = var.project_name
}

resource "docker_image" "api" {
  name = "tp1_api:latest"

  build {
    context    = "${path.module}/.."
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "db" {
  name  = "tp1_db"
  image = "postgres:16-alpine"

  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}",
  ]

  networks_advanced {
    name = docker_network.app.name
  }

  ports {
    internal = 5432
    external = 5432
  }
}

resource "docker_container" "adminer" {
  name  = "tp1_adminer"
  image = "adminer:latest"

  networks_advanced {
    name = docker_network.app.name
  }

  ports {
    internal = 8080
    external = var.adminer_port
  }

  depends_on = [docker_container.db]
}

resource "docker_container" "api" {
  name  = "tp1_api"
  image = docker_image.api.image_id

  env = [
    "PORT=${var.api_port}",
    "APP_ENV=${var.app_env}",
    "DATABASE_URL=postgresql://${var.db_user}:${var.db_password}@${docker_container.db.name}:${docker_container.db.ports.0.external}/${var.db_name}",
  ]

  networks_advanced {
    name = docker_network.app.name
  }

  ports {
    internal = 3000
    external = var.api_port
  }

  depends_on = [docker_container.db]
}
