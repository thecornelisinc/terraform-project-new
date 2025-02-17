resource "aws_db_instance" "main" {
  allocated_storage           = 10
  db_name                     = var.db_name
  engine                      = "mysql"
  engine_version              = "8.0"
  instance_class              = var.instance_class
  manage_master_user_password = true
  username                    = "admin"
  parameter_group_name        = "default.mysql8.0"
  identifier = "terraform"
}