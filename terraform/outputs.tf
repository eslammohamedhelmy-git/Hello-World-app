output "application_url" {
  value = "http://localhost:${var.host_port}"
}
output "newrelic_enabled" {
  value = var.enable_newrelic
}