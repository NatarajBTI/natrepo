data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null
}



#Verify the pipeline install status & get the the data on pipeline success status or in case of failure, get the data on failed task.
data "external" "install_verify" {

  program = ["python3", "${path.module}/scripts/installVerify.py", var.deployment_flavour, var.mas_instance_id]
  query = {
    KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
  }
  
}

#Get the maximo admin URL if the deployment is successful.
data "external" "maximo_admin_url" {

  program = ["python3", "${path.module}/scripts/getAdminURL.py", var.deployment_flavour, var.mas_instance_id, var.mas_workspace_id]
  query = {
    KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
  }
  depends_on = [data.external.install_verify]
}
