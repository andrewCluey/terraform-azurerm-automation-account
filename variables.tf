variable "location" {
  type        = string  
  description = "The Azure region where the new resources will be created."
  default     = "uksouth"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where new resources will reside."
}

variable "automation_account_name" {
  type        = string
  description = "The name to assign to the new Automation Account."
}

variable "sku_name" {
  type        = string
  description = "Only Basic SKU available at present"
  default     = "Basic"
}

variable "enable_diagnostic_settings" {
  type        = bool
  description = "True/False value to choose whether or not to send Automation Account Diagnostic logs to a Log Analytics Workspace."
  default     = false
}

variable "aa_diagnostic_settings" {
    type = object({
        name                       = string
        log_analytics_workspace_id = string
    })
    description = "Cnfiguration details for the diagnostic settings and destination (if deployed)."
    default     = null
}


variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the new resources"
}