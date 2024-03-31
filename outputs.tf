########################################################################################################################
# Outputs
########################################################################################################################

output "maximo_admin_url" {
  description = "Admin URL of Manage application is"
  value       = jsonencode(data.external.maximo_admin_url.result.admin_url)
}
