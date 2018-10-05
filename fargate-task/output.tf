output "task_iam_role_id" {
  description = "Id of the iam role for the task"
  value       = "${aws_iam_role.ecs_service_task_role.id}"
}

output "task_iam_role_arn" {
  description = "ARN of the iam role for the task"
  value       = "${aws_iam_role.ecs_service_task_role.arn}"
}

output "task_definition_arn" {
  description = "Id of the task definition"
  value       = "${aws_ecs_task_definition.task.arn}"
}

output "task_definition_id" {
  description = "ARN of the task definition"
  value       = "${aws_ecs_task_definition.task.id}"
}
