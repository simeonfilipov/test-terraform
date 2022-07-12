resource "aws_instance" "instance-1" {
  ami           = var.aws_ami //defined in variables, Ubuntu 22.04
  instance_type = var.instance_type
  subnet_id     = aws_subnet.staging-subnet.id
  key_name      = "ubuntu"
  #subnet_id                   = aws_subnet.staging-subnet.id
  #security_groups = [aws_security_group.instances.name]
  vpc_security_group_ids = [aws_security_group.instances.id]
  tags = {
    "name" = "test-instance1"
  }
  user_data = <<-EOF
              #!/bin/bash
              echo "server 1" > index.html
              python3 -m http.server 8080 &
  EOF
}
# create second vm
resource "aws_instance" "instance-3" {
  ami           = var.aws_ami //defined in variables, Ubuntu 22.04
  instance_type = var.instance_type
  subnet_id     = aws_subnet.staging-subnet2.id
  key_name      = "ubuntu"
  #subnet_id                   = aws_subnet.staging-subnet.id
  vpc_security_group_ids = [aws_security_group.instances.id]
  #security_groups = [aws_security_group.instances.name]
  tags = {
    "name" = "test-instance2"
  }
  user_data = <<-EOF
              #!/bin/bash
              echo "server 2" > index.html
              python3 -m http.server 8080 &
  EOF
}
