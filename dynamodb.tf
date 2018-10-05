// Demo database with to keys, ClientIp and Service IP
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "DemoTable"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "ClientIP"
  range_key      = "ServerIP"

  attribute {
    name = "ClientIP"
    type = "S"
  }

  attribute {
    name = "ServerIP"
    type = "S"
  }

  tags {
    Name        = "dynamodb-table-demo"
    Environment = "demo"
  }
}
