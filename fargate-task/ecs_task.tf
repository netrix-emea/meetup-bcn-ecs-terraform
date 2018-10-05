//  Task Definition, fargate only
resource "aws_ecs_task_definition" "task" {
  family = "${var.family}"

  task_role_arn            = "${aws_iam_role.ecs_service_task_role.arn}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.cpu}"
  memory                   = "${var.memory}"
  execution_role_arn       = "${var.task_execution_role}"

  container_definitions = "${data.template_file.task_definition.rendered}"
}

# Specify the family to find the latest ACTIVE revision in that family.
data "aws_ecs_task_definition" "task" {
  task_definition = "${aws_ecs_task_definition.task.family}"

  depends_on = ["aws_ecs_task_definition.task"]
}

// ECS Service
resource "aws_ecs_service" "service" {
  name        = "${var.family}"
  cluster     = "${var.cluster_name}"
  launch_type = "FARGATE"

  // Networkconfiguration onlu required for awsvpc networking
  network_configuration {
    subnets          = ["${var.subnet_ids}"]
    security_groups  = ["${var.security_group_ids}"]
    assign_public_ip = "${var.assign_public_ip}"
  }

  desired_count = "${var.desired_count}"

  // Retrieve the latest revision number from AWS.
  // When running a deploy it will show a change in the plan
  // But since there is no actual change there is no action executed by the aws api
  task_definition = "${var.family}:${max(aws_ecs_task_definition.task.revision, data.aws_ecs_task_definition.task.revision)}"

  depends_on = ["aws_ecs_task_definition.task"]
}

// Create a task definition from the json template file
data "template_file" "task_definition" {
  template = "${file("${path.module}/task_definition.json")}"

  vars {
    cpu           = "${var.cpu}"
    mem           = "${var.memory}"
    image         = "${var.image}"
    service_name  = "${var.service}"
    cluster_name  = "${var.cluster_name}"
    region        = "${var.aws_region}"
    hostport      = "${var.host_port}"
    containerport = "${var.container_port}"
    log_group     = "${element(split(":",var.log_group_arn),6)}"
  }
}
