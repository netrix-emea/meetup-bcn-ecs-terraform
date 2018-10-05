// The Amazon Resource Name (ARN) specifying the role
output "execution_role_id" {
  description = "IAM Role ID for execution Role"
  value       = "${aws_iam_role.ecs_service_task_execution_role.id}"
}

// The Amazon Resource Name (ARN) specifying the role
output "execution_role_arn" {
  description = "IAM Role ARN for execution Role"
  value       = "${aws_iam_role.ecs_service_task_execution_role.arn}"
}

// The Amazon Resource Name (ARN) that identifies the cluster
output "ecs_cluster_id" {
  description = "Id of the ECS Cluster"
  value       = "${aws_ecs_cluster.ecs.id}"
}

// The name of the ECS cluster
output "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  value       = "${aws_ecs_cluster.ecs.name}"
}

output "log_group_arn" {
  description = "ARN of the Cloudwatch log group"
  value       = "${aws_cloudwatch_log_group.log_group.arn}"
}
