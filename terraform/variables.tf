variable "image_name" {
  description = "Container image name"
  type        = string
}

variable "image_tag" {
  description = "Container image tag"
  type        = string
  default     = "main"
}

variable "container_name" {
  description = "Docker container name"
  type        = string
  default     = "hello-world-app"
}

variable "container_port" {
  description = "Port exposed by the application inside the container"
  type        = number
  default     = 3000
}

variable "host_port" {
  description = "Port exposed on the runner host"
  type        = number
  default     = 3000
}

variable "newrelic_license_key" {
  description = "New Relic license key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "enable_newrelic" {
  description = "Enable New Relic infrastructure agent"
  type        = bool
  default     = false
}