locals {
  kubectl_context_name = "minikube"
  kafka_endpoint       = "${var.docker_host_ip}:9092"
  namespace            = "streamer-apps"
}

module "apps" {
  source = "../modules/apps"

  kubectl_context_name = "${local.kubectl_context_name}"
  kafka_endpoint       = "${local.kafka_endpoint}"
  namespace            = "${local.namespace}"

  node-app = "${var.node-app}"
}
