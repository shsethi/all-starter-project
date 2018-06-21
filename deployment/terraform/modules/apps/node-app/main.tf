locals {
  app_name                  = "node-app"
  config_file_path          = "${path.module}/templates/node-app_conf.tpl"
  deployment_yaml_file_path = "${path.module}/templates/deployment_yaml.tpl"
  count                     = "${var.enabled?1:0}"
  checksum                  = "${sha1("${data.template_file.config_data.rendered}")}"
  configmap_name            = "node-app-${local.checksum}"
}

resource "kubernetes_config_map" "node-config" {
  metadata {
    name      = "${local.configmap_name}"
    namespace = "${var.namespace}"
  }

  data {
    "node-app.conf" = "${data.template_file.config_data.rendered}"
  }

  count = "${local.count}"
}

data "template_file" "config_data" {
  template = "${file("${local.config_file_path}")}"

  vars {
    kafka_endpoint = "${var.kafka_endpoint}"
  }
}

//using kubectl to craete deployment construct since its not natively support by the kubernetes provider
data "template_file" "deployment_yaml" {
  template = "${file("${local.deployment_yaml_file_path}")}"

  vars {
    app_name            = "${local.app_name}"
    namespace           = "${var.namespace}"
    image               = "${var.image}"
    replicas            = "${var.replicas}"
    configmap_name      = "${local.configmap_name}"
  }
}

resource "null_resource" "kubectl_apply" {
  triggers {
    template = "${data.template_file.deployment_yaml.rendered}"
  }

  provisioner "local-exec" {
    command = "echo '${data.template_file.deployment_yaml.rendered}' | kubectl apply -f - --context ${var.kubectl_context_name}"
  }

  count = "${local.count}"
}

resource "null_resource" "kubectl_destroy" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.deployment_yaml.rendered}' | kubectl delete -f - --context ${var.kubectl_context_name}"
    when    = "destroy"
  }

  count = "${local.count}"
}
