########################################################################################################################
# Outputs
########################################################################################################################

output "maximo_admin_url" {
  description = "Admin URL of MAS/Manage application"
  value       = jsondecode(data.local_file.admin_url.content)
}

output "pipeline_execution_status" {
  description = "Status of pipeline execution is"
  value       = jsondecode(data.local_file.pipeline_status.content)
}
