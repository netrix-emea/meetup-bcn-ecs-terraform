variable "name" {
  description = "ECS Cluster name"
  default     = "demo"
}

variable "tags" {
  description = "Tags for resources"
  default     = {}
}

variable "gdpr_delete_days" {
  description = "Clean up resources after x days"
  default     = 7
}
