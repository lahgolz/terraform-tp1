terraform {
  required_version = ">= 1.0.0"

  required_providers {
    docker = {
      source  = "registry.opentofu.org/kreuzwerker/docker"
      version = "~> 3.9.0"
    }
  }
}