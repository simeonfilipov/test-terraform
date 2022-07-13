resource "aws_instance" "instance-1" {
  ami           = var.aws_ami //defined in variables, Ubuntu 22.04
  instance_type = var.instance_type
  key_name      = "ubuntu"
network_interface {
  device_index = 0
  network_interface_id = aws_network_interface.instance1-nic.id
}
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
resource "aws_instance" "instance-2" {
  ami           = var.aws_ami //defined in variables, Ubuntu 22.04
  instance_type = var.instance_type
  key_name      = "ubuntu"
network_interface {
  device_index = 0
  network_interface_id = aws_network_interface.instance2-nic.id
}
  tags = {
    "name" = "test-instance2"
  }
  user_data = <<-EOF
              #!/bin/bash
              echo "server 2" > index.html
              python3 -m http.server 8080 &
  EOF
}
