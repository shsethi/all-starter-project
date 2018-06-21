module "node-app" {
  source = "node-app"

  image                = "${var.node-app["image"]}"
  replicas             = "${var.node-app["node-app-instances"]}"
  namespace            = "${var.namespace}"
  enabled              = "${var.node-app["enabled"]}"
  kafka_endpoint       = "${var.kafka_endpoint}"
  kubectl_context_name = "${var.kubectl_context_name}"
}
