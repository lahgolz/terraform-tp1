provider "docker" {}

resource "docker_network" "app" {
  name = var.project_name
}

resource "docker_image" "api" {
  name = "${var.project_name}_api:latest"

  build {
    context    = "${path.module}/../app"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "db" {
  name  = "${var.project_name}_db"
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
  name  = "${var.project_name}_adminer"
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
  name  = "${var.project_name}_api"
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
