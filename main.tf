data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null
}

locals {
  admin_url_file = "${path.module}/result.txt"
}

resource "null_resource" "maximo_admin_url" {  
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "${path.module}/scripts/testscript.sh var.deployment_flavour, var.mas_instance_id"
    environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
}

data "local_file" "admin_url" {
  filename = local.admin_url_file
  depends_on = [null_resource.maximo_admin_url]
}

