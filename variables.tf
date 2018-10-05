variable "ecs_cluster_name" {
  description = "Name of the cluster to create"
  default     = "demo"
}

variable "ecr_repository_name" {
  descrioption = "Name of the Repository to create"
  default      = "demo"
}

variable "ecs_task" {
  description = "Configuration for the task"

  default = {
    cluster        = "demo"
    service        = "demo"
    family         = "demo"
    cpu            = "256"
    memory         = "512"
    desired_count  = "0"
    host_port      = 8080
    container_port = 8080
  }
}
