# #default NIC for WEB instance-1, static internal IP
resource "aws_network_interface" "instance1-nic" {
  subnet_id       = aws_subnet.staging-subnet.id
  private_ips     = ["10.182.10.10"]
  security_groups = [aws_security_group.instances.id,aws_security_group.mysql-sg.id]
}

#default NIC for WEBinstance-2, static internal IP
resource "aws_network_interface" "instance2-nic" {
  subnet_id       = aws_subnet.staging-subnet2.id
  private_ips     = ["10.182.20.10"]
  security_groups = [aws_security_group.instances.id,aws_security_group.mysql-sg.id]
}