########################################################################################################################
# Outputs
########################################################################################################################

output "pipeline_execution_status" {
  description = "Status of pipeline execution is"
  value       = data.external.install_verify.result.PipelineRunStatus
}