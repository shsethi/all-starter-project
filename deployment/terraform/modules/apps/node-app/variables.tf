variable "image" {}
variable "replicas" {}
variable "namespace" {}
variable "enabled" {}

variable "kafka_endpoint" {}
variable "kubectl_context_name" {
    default = "minikube"
}
