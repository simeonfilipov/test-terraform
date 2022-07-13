# resource "aws_db_instance" "mysql-instance" {
#   allocated_storage = 10
#   engine            = "mysql"
#   engine_version    = "8.0.28"
#   instance_class    = var.db_size
#   username          = var.db_user
#   password          = var.db_pass
#   port              = 3306
#   tags = {
#     "name" = "mysql"
#   }
# }
