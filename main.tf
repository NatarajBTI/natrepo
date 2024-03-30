data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null
}


resource "null_resource" "install_verify" {

provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "${path.module}/scripts/installVerify.sh ${var.deployment_flavour} ${var.mas_instance_id}"
	environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
}

resource "null_resource" "admin_url" {

provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "${path.module}/scripts/getAdminURL.sh ${var.deployment_flavour} ${var.mas_instance_id} ${var.mas_workspace_id}"
	environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
  depends_on = [null_resource.install_verify]
}

data "external" "get_pipeline_result" {

  program    = ["/bin/bash", "-c", "${path.module}/scripts/getResult.sh"]
  query = {
    KUBECONFIG   = data.ibm_container_cluster_config.cluster_config.config_file_path
  }
depends_on = [null_resource.install_verify]
}

data "external" "get_admin_url" {

  program    = ["/bin/bash", "-c", "${path.module}/scripts/getURL.sh"]
  query = {
    KUBECONFIG   = data.ibm_container_cluster_config.cluster_config.config_file_path
  }
depends_on = [null_resource.admin_url]
}
