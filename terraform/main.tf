terraform {
  required_version = ">= 1.6.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"

  registry_auth {
    address     = "ghcr.io"
    config_file = pathexpand("~/.docker/config.json")
  }
}

resource "docker_image" "app" {
  name         = "${var.image_name}:${var.image_tag}"
  keep_locally = false
}

resource "docker_container" "app" {
  name  = var.container_name
  image = docker_image.app.image_id

  ports {
    internal = var.container_port
    external = var.host_port
  }

  env = [
    "PORT=${var.container_port}"
  ]

  restart = "unless-stopped"
}

resource "docker_image" "newrelic_infra" {
  count = var.enable_newrelic ? 1 : 0
  name  = "newrelic/infrastructure:latest"
}

resource "docker_container" "newrelic_infra" {
  count = var.enable_newrelic ? 1 : 0

  name  = "newrelic-infra"
  image = docker_image.newrelic_infra[0].image_id

  env = [
    "NRIA_LICENSE_KEY=${var.newrelic_license_key}"
  ]

  volumes {
    host_path      = "/"
    container_path = "/host"
    read_only      = true
  }

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
    read_only      = false
  }

  capabilities {
    add = ["SYS_PTRACE"]
  }

  network_mode = "host"

  restart = "unless-stopped"
}