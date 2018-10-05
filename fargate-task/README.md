# Terraform module: fargate-task

Create a ECS Fargate Task.
it listens on the host-port on the internal and public ip

Example:
```
module "ecs_task" {
  source              = "fargate-task"
  task_execution_role = "${module.ecs_cluster.execution_role_arn}"
  service             = "demo"
  family              = "demo"
  cpu                 = "256"
  memory              = "512"
  desired_count       = "1"
  image               = "${aws_ecr_repository.registry.repository_url}:latest"
  host_port           = "8080"
  container_port      = "8080"
  cluster_name        = "demo"

  aws_region         = "${data.aws_region.current.name}"
  subnet_ids         = "${data.aws_subnet_ids.default.ids}"
  security_group_ids = ["${aws_security_group.ecs_demo.id}"]
  assign_public_ip   = true
  log_group_arn      = "${module.ecs_cluster.log_group_arn}"
}
```

Fargate Ip can be retreive with the AWS WebConsole or by this cli command
`aws ec2 describe-network-interfaces --query "NetworkInterfaces[].[Description,Association.PublicIp]" --output table`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assign_public_ip |  | string | `false` | no |
| aws_region |  | string | - | yes |
| cluster_name | Name of the ecs cluster for the task | string | - | yes |
| container_port | Port where the container is listening on | string | `0` | no |
| cpu | CPU Units for the task | string | `256` | no |
| desired_count | Amount of tasks to start | string | `1` | no |
| family | Name of the family to be created | string | - | yes |
| host_port | Host Port to be mapped to container port | string | `0` | no |
| image | Path of docker image including tag | string | - | yes |
| log_group_arn |  | string | - | yes |
| memory | Memory (mb)  for the task | string | `512` | no |
| security_group_ids |  | list | `<list>` | no |
| service | Name of the service to be created | string | - | yes |
| subnet_ids |  | list | `<list>` | no |
| tags |  | string | `<map>` | no |
| task_execution_role |  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| task_definition_arn | Id of the task definition |
| task_definition_id | ARN of the task definition |
| task_iam_role_arn | ARN of the iam role for the task |
| task_iam_role_id | Id of the iam role for the task |
