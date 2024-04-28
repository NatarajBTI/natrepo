data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null
}

#Verify the pipeline install status & get the the data on pipeline success status or in case of failure, get the data on failed task.
resource "null_resource" "install_verify" {  
  
provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "${path.module}/scripts/installVerify.sh ${var.deployment_flavour} ${var.mas_instance_id}"
	environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
}


resource "null_resource" "maximo_admin_url" {  
  
provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "${path.module}/scripts/getAdminURL.sh ${var.deployment_flavour} ${var.mas_instance_id}"
	environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
  depends_on = [null_resource.install_verify]
}

locals {
  pipeline_status_file = "${path.module}/result.txt"
}

locals {
  admin_url_file = "${path.module}/url.txt"
}

data "local_file" "admin_url" {
  depends_on = [null_resource.maximo_admin_url]
  filename = local.admin_url_file  
}

data "local_file" "pipeline_status" {
  depends_on = [null_resource.maximo_admin_url]
  filename = local.pipeline_status_file 
}