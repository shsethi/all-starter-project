variable "kafka_endpoint" {}
variable "namespace" {}

variable "kubectl_context_name" {
  default = "minikube"
}

variable "node-app" {
  type = "map"
}
