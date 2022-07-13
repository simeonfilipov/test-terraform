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