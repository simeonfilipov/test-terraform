resource "aws_instance" "instance-1" {
  ami           = var.aws_ami //defined in variables, Ubuntu 22.04
  instance_type = var.instance_type
  key_name      = "ubuntu"
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.instance1-nic.id
  }
  tags = {
    "name" = "test-instance1"
  }
  depends_on = [
    aws_efs_mount_target.efs-mount-sub1
  ]
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("ubuntu.pem")
    host        = aws_instance.instance-1.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /mnt/efs",
      "sudo apt-get install nfs-common -y",
      "sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs-instances.dns_name}:/ /mnt/efs",
      "sudo apt install mysql-client -y"
    ]
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
    device_index         = 0
    network_interface_id = aws_network_interface.instance2-nic.id
  }
  tags = {
    "name" = "test-instance2"
  }
  depends_on = [
    aws_efs_mount_target.efs-mount-sub2
  ]
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("ubuntu.pem")
    host        = aws_instance.instance-2.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /mnt/efs",
      "sudo apt-get install nfs-common -y",
      "sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs-instances.dns_name}:/ /mnt/efs",
      "sudo apt install mysql-client -y"
    ]
  }
  user_data = <<-EOF
              #!/bin/bash
              echo "server 2" > index.html
              python3 -m http.server 8080 &
  EOF
}
