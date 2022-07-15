#creating mysql instance
 resource "aws_db_instance" "mysql-instance" {
   allocated_storage      = 10
   engine                 = "mysql"
   engine_version         = "8.0.28"
   instance_class         = var.db_size
   username               = var.db_user
   password               = var.db_pass
   port                   = 3306
   publicly_accessible    = false
   vpc_security_group_ids = [aws_security_group.mysql-sg.id]
   db_subnet_group_name = aws_db_subnet_group.mysql-subnets.name
   skip_final_snapshot = true
   tags = {
     "name" = "mysql"
   }
 }
 resource "aws_db_subnet_group" "mysql-subnets" {
   subnet_ids = [aws_subnet.staging-subnet.id,aws_subnet.staging-subnet2.id]
   name       = "mysql-subnets"
 }