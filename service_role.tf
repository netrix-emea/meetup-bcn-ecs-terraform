## !! NOTE !!
# This role is created by the gui when you use ECS
# When never used before or a clean account enable this
#

resource "aws_iam_service_linked_role" "ecs" {
  aws_service_name = "ecs.amazonaws.com"
}
