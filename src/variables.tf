variable "location" {
  type        = string
  default     = "westeurope"
  description = "Where should all Azure resources be created"
}

variable "tags" {
  type        = map
  default     = {}
  description = "Provide custom tags, that will be associated with all resources"
}

variable "app_service_plan" {
  type        = object({ tier = string, size = string })
  default     = { tier = "Standard", size = "S2" }
  description = "Control the App Service Plan SKU"
}
