// Create Repository and output it to console
resource "aws_ecr_repository" "registry" {
  name = "${var.ecr_repository_name}"
}

output "ecr_url" {
  value = "${aws_ecr_repository.registry.repository_url}"
}
