data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null
}

data "external" "maximo_admin_url" {

  program    = ["bash", "-c", "${path.module}/scripts/getAdminURL.sh ${var.deployment_flavour} ${var.mas_instance_id}"]
  query = {
    KUBECONFIG   = data.ibm_container_cluster_config.cluster_config.config_file_path
  }

}
