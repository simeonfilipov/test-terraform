#aws access key, defined in tfvars
variable "aws_access_key" {
  description = "AWS Access key"
  type        = string
  sensitive = true
}
#aws secret key, defined in tfvars
variable "aws_secret_key" {
  description = "AWS Secret key"
  type        = string
  sensitive = true
}
#default aws region
variable "aws_region" {
  type    = string
  default = "eu-central-1"
}
#OS AMI code
variable "aws_ami" {
  type    = string
  default = "ami-065deacbcaac64cf2" //UBUNTU 22.04
}

#default instance type for compute VMs
variable "instance_type" { 
  type    = string
  default = "t2.micro"
}

#mysql username, defined in tfvars file
variable "db_user" {
  type      = string
  sensitive = true
}

#mysql password, defined in tfvars file
variable "db_pass" {
  type      = string
  sensitive = true
}

#db size instance
variable "db_size" {
  type    = string
  default = "db.t3.micro"
}
#definition of the email which will receive updates for the SNS topic, defined in tfvars file
variable "sns-email" {
  type = string
  sensitive = true
}