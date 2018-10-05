# meetup-bcn-ecs-terraform
Terraform code for BCN Tech Talks Meetup 4-10-2018
Jacob Verhoeks jjverhoeks@edrans.com

This is an example repository to run a ECS Fargate Service managed by terraform

###  Terraform

First time initialisation of the terraform state  
```
terraform init
```

View the changes and applies after manual confirmation  
```
terraform apply
```

Remove all configuration for AWS
```
terraform destroy
```

###  Configuration

Configuration Changes can be done in variables.tf
```
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
```

After the infrastructure is create it needs a docker image to load.
Until this is done the task will keeps failing.

Go to the Docker-web directory and read the [README.md](README.md)
It requires some manual changes of the repository url. Terraform shows this from the output: ecr_url
