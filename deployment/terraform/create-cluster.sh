#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAFORM=terraform


#### Installing apps
cd $DIR/deployment/terraform/apps

$TERRAFORM init
$TERRAFORM apply -var docker_host_ip=$(minikube ip)