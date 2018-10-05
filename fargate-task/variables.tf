variable "service" {
  description = "Name of the service to be created"
  type        = "string"
}

variable "family" {
  description = "Name of the family to be created"
  type        = "string"
}

variable "cluster_name" {
  description = "Name of the ecs cluster for the task"
  type        = "string"
}

variable "cpu" {
  description = "CPU Units for the task"
  default     = "256"
}

variable "memory" {
  description = "Memory (mb)  for the task"
  default     = "512"
}

variable "image" {
  description = "Path of docker image including tag"
  type        = "string"
}

variable "host_port" {
  description = "Host Port to be mapped to container port"
  default     = 0
}

variable "container_port" {
  description = "Port where the container is listening on"
  default     = 0
}

variable "desired_count" {
  description = "Amount of tasks to start"
  default     = 1
}

variable "task_execution_role" {}

variable "aws_region" {}

variable "subnet_ids" {
  type    = "list"
  default = []
}

variable "security_group_ids" {
  type    = "list"
  default = []
}

variable "assign_public_ip" {
  default = false
}

variable "log_group_arn" {}

variable "tags" {
  default = {}
}
