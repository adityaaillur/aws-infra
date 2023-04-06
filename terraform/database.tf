resource "aws_db_parameter_group" "mysql_parameter_group" {
  name        = "mysql-parameter-group"
  family      = "mysql8.0"
  description = "Custom parameter group for mysql"
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [for subnet in aws_subnet.private_subnets : subnet.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "main" {

  engine                 = var.db_engine
  instance_class         = var.db_instance
  identifier             = var.db_instance_identifier
  db_name                = var.db_name
  username               = var.db_username
  multi_az               = var.db_multi_az
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.default.name
  parameter_group_name   = aws_db_parameter_group.mysql_parameter_group.name
  publicly_accessible    = false
  allocated_storage      = 10
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot    = true

}