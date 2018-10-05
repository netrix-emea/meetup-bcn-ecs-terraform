// Create IAM Role for this service
resource "aws_iam_role" "ecs_service_task_role" {
  name_prefix = "EcsTask-${var.cluster_name}-"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
