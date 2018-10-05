// Use cluster module to create the Cluster
module ecs_cluster {
  source = "fargate-cluster"
  name   = "${var.ecs_cluster_name}"
}

// use task module to create the fargate task
module "ecs_task" {
  source              = "fargate-task"
  task_execution_role = "${module.ecs_cluster.execution_role_arn}"
  service             = "${var.ecs_task["service"]}"
  family              = "${var.ecs_task["family"]}"
  cpu                 = "${var.ecs_task["cpu"]}"
  memory              = "${var.ecs_task["memory"]}"
  desired_count       = "${var.ecs_task["desired_count"]}"
  image               = "${aws_ecr_repository.registry.repository_url}:latest"
  host_port           = "${var.ecs_task["host_port"]}"
  container_port      = "${var.ecs_task["container_port"]}"
  cluster_name        = "${var.ecs_cluster_name}"

  aws_region         = "${data.aws_region.current.name}"
  subnet_ids         = "${data.aws_subnet_ids.default.ids}"
  security_group_ids = ["${aws_security_group.ecs_demo.id}"]
  assign_public_ip   = true
  log_group_arn      = "${module.ecs_cluster.log_group_arn}"
}

// SG For the Task, opens the container port to the world
resource "aws_security_group" "ecs_demo" {
  name   = "SGECS-${var.ecs_cluster_name}-${var.ecs_task["service"]}"
  vpc_id = "${data.aws_vpc.default.id}"

  # allow all open for now
  ingress {
    from_port   = "${var.ecs_task["host_port"]}"
    to_port     = "${var.ecs_task["host_port"]}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// additional policy for the task to access dynamodb
resource "aws_iam_role_policy" "ecs_task_allow_dynamodb_demo" {
  name = "ecs-allow-dynamodb-demo"
  role = "${module.ecs_task.task_iam_role_id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListAndDescribe",
            "Effect": "Allow",
            "Action": [
                "dynamodb:List*",
                "dynamodb:DescribeReservedCapacity*",
                "dynamodb:DescribeLimits",
                "dynamodb:DescribeTimeToLive"
            ],
            "Resource": "*"
        },
        {
            "Sid": "SpecificTable",
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGet*",
                "dynamodb:DescribeStream",
                "dynamodb:DescribeTable",
                "dynamodb:Get*",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:BatchWrite*",
                "dynamodb:CreateTable",
                "dynamodb:Delete*",
                "dynamodb:Update*",
                "dynamodb:PutItem"
            ],
            "Resource": "${aws_dynamodb_table.basic-dynamodb-table.arn}"
        }
    ]
}
EOF
}
