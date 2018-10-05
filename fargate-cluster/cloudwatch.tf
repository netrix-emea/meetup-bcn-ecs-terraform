// Create Cloudwatch Log Group with retention
resource "aws_cloudwatch_log_group" "log_group" {
  name_prefix       = "/ecs/cluster/${var.name}-"
  retention_in_days = "${var.gdpr_delete_days}"

  tags = "${merge(var.tags,map(
    "role"               , "cloudwatch",
    "Name"               , "/ecs/cluster/${var.name}",
  ))}"
}
