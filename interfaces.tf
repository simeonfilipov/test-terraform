# #default NIC for WEB instance-1
resource "aws_network_interface" "instance1-nic" {
  subnet_id       = aws_subnet.staging-subnet.id
  private_ips     = ["10.182.10.10"]
  security_groups = [aws_security_group.instances.id,aws_security_group.mysql-sg.id]
}

#default NIC for WEBinstance-2
resource "aws_network_interface" "instance2-nic" {
  subnet_id       = aws_subnet.staging-subnet2.id
  private_ips     = ["10.182.20.10"]
  security_groups = [aws_security_group.instances.id,aws_security_group.mysql-sg.id]
}

# resource "aws_eip" "eip-instance1" {
#   vpc                       = true
#   network_interface         = aws_network_interface.instance1-nic.id
#   instance = aws_instance.instance-1.id
# }
# resource "aws_eip" "eip-instance2" {
#   vpc                       = true
#   network_interface         = aws_network_interface.instance1-nic.id
#   instance = aws_instance.instance-2.id
# }

# #NIC 1 for mysql RDS
# resource "aws_network_interface" "mysqlnic1" {
#   subnet_id       = aws_subnet.staging-subnet.id
#   private_ips     = ["10.182.10.11"]
#   security_groups = [aws_security_group.instances.id]
# }
# #NIC 2 for mysql RDS
# resource "aws_network_interface" "mysqlnic2" {
#   subnet_id       = aws_subnet.staging-subnet2.id
#   security_groups = aws_security_group.instances.id
#   private_ips     = ["10.182.20.11"]
# }
