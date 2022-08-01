# API Management
variable "resource_group" {
    description = "APIM: Resource Group"
    default     = ""
}

variable "apim_name" {
    description = "APIM: Name of API Management"
    default     = ""
}

variable "subscription_id" {
}

variable "client_id" {
}

variable "client_secret" {
}

variable "tenant_id" {
}

variable "resource_group_name" {
}

variable "location" {
}

variable "tags" {
}

variable "virtual_network_name" {
}

variable "virtual_network_address" {
}

variable "sub_network_name" {
}

variable "sub_network_address" {
}

variable "network_interface_name" {
}

variable "virtual_machine_name" {
}

variable "virtual_machine_size" {
}

variable "virtual_machine_admin" {
}

variable "public_ip_name" {
}

variable "network_security_group_name" {
}

variable "cluster_aks_name" {
}

variable "cluster_aks_prefix" {
}

variable "cluster_aks_node_count" {
}

variable "aks_location" {
}

variable "api_management_name" {
}

variable "api_management_publisher_name" {
}

variable "api_management_publisher_email" {
}

variable "cors_origins" {
   type    = list
   default = []
}
variable "cors_methods" {
  type    = list
  default = []
 }
variable "cors_headers" {
   type    = list
   default = []
}

# API: Policy Link
variable "api_policy_link" {
  description = "Link of policy without (https://)"
}