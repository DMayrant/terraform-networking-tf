
resource "aws_db_instance" "default" {
  allocated_storage    = var.storage_size
  db_name              = "MySQL_db_instance"
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = "admin"
  password             = "admin12345"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  tags = merge(local.common_tags, {
    Name = "MySQL DB instance"
  })
}