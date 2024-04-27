##############################################################################
# Input Variables
##############################################################################

variable "ibmcloud_api_key" {
  description = "Enter the IBM Cloud APIkey that's associated with this IBM Cloud account"
  type        = string
  sensitive   = true  
}

variable "cluster_id" {
  type        = string
  description = "Enter Id of the target IBM Cloud Red Hat OpenShift Cluster"
  nullable    = false
  default     = "masdaapr24-workload-cluster"
}

variable "region" {
  type        = string
  description = "Enter region of the target IBM Cloud Red Hat OpenShift Cluster"
  nullable    = false
  default	  = "ca=tor"
}

variable "cluster_config_endpoint_type" {
  description = "Specify which type of endpoint to use for for cluster config access: 'default', 'private', 'vpe', 'link'. 'default' value will use the default endpoint of the cluster."
  type        = string
  default     = "default"
  nullable    = false # use default if null is passed in
  validation {
    error_message = "Invalid Endpoint Type! Valid values are 'default', 'private', 'vpe', or 'link'"
    condition     = contains(["default", "private", "vpe", "link"], var.cluster_config_endpoint_type)
  }
}