variable "docker_host_ip" {}

variable "node-app" {
  type = "map"

  default = {
    enabled            = true
    image              = "node-app:latest"
    node-app-instances = 1
  }
}
