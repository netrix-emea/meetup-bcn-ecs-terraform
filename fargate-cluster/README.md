# Terraform Module Fargate-cluster

Create a Fargate Cluster with an Task Execution Role.
This role can be using for tasks

Also  defines a default cloudwatch log group with log retention date

Example:
```
module ecs_cluster {
  source = "fargate-cluster"
  name   = "demo"
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| gdpr_delete_days | Clean up resources after x days | string | `7` | no |
| name | ECS Cluster name | string | `demo` | no |
| tags | Tags for resources | string | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| ecs_cluster_id | Id of the ECS Cluster |
| ecs_cluster_name | Name of the ECS Cluster |
| execution_role_arn | IAM Role ARN for execution Role |
| execution_role_id | IAM Role ID for execution Role |
| log_group_arn | ARN of the Cloudwatch log group |
