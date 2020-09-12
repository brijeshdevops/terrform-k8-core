
data "kubectl_path_documents" "k8_core" {
  pattern = "./k8-core/*.yaml"
  vars = {
    javaapp_docker_image_prefix = "devopstraining143"
    eks_cluster_name            = local.cluster_id
  }
}

resource "kubectl_manifest" "k8_core_deploy" {
  count     = length(data.kubectl_path_documents.k8_core.documents)
  yaml_body = element(data.kubectl_path_documents.k8_core.documents, count.index)
}