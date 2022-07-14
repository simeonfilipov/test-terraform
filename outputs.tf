/* output "vm1_public_ip" {
  value = aws_instance.VM1.public_ip
}

output "vm2_public_ip" {
  value = aws_instance.VM2.public_ip
}
 */

output "lb_dns_name" {
  value = aws_lb.staging-load-balancer.dns_name
}

  output "instance-1-public" {
    value = aws_instance.instance-1.public_ip
  }
  output "instance-2-public" {
    value = aws_instance.instance-2.public_ip
  }