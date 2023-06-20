resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = var.mydb
  engine               = var.myengine
  engine_version       = var.engineversion
  instance_class       = var.instancetype
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}