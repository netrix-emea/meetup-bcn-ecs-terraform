// ECS Cluster
resource "aws_ecs_cluster" "ecs" {
  name = "${var.name}"
}

// FARGATE Execution Role
resource "aws_iam_role" "ecs_service_task_execution_role" {
  name_prefix = "EcsExecution-${var.name}-"

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

// Attach  Default Execution Policy
resource "aws_iam_role_policy_attachment" "ecs_task_basic" {
  role       = "${aws_iam_role.ecs_service_task_execution_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

// Additional Policy to allow the task to manage cloudwatch log groups
resource "aws_iam_role_policy" "ecs_task_allow_awslogs" {
  name = "ecs-allow-awslogs"
  role = "${aws_iam_role.ecs_service_task_execution_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
    ],
      "Resource": [
        "arn:aws:logs:*:*:*"
    ]
  }
 ]
}
EOF
}
