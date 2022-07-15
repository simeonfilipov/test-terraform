##### Outputs from all instances

#public address to reach the LB
output "lb_dns_name" {
  value = aws_lb.staging-load-balancer.dns_name
}

#public IP of primary instance
output "instance-1-public" {
  value = aws_instance.instance-1.public_ip
}
#public IP of secondary instance
output "instance-2-public" {
  value = aws_instance.instance-2.public_ip
}

##### EFS values
output "efs-id" {
  value = aws_efs_file_system.efs-instances.id
}
output "efs-dns" {
  value = aws_efs_file_system.efs-instances.dns_name
}
output "efs-ip-sub1" {
  value = aws_efs_mount_target.efs-mount-sub1.ip_address
}
output "efs-ip-sub2" {
  value = aws_efs_mount_target.efs-mount-sub2.ip_address
}
#### RDS string for connecting from EC2 instances
output "mysql-rds" {
  value = aws_db_instance.mysql-instance.endpoint
}