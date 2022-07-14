variable "aws_access_key" {
  description = "AWS Access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret key"
  type        = string
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "aws_ami" {
  type    = string
  default = "ami-065deacbcaac64cf2" //UBUNTU 22.04
}

variable "instance_type" { //default instance type for compute VMs
  type    = string
  default = "t2.micro"
}

#mysql username
variable "db_user" {
  type      = string
  sensitive = true
}

#mysql password
variable "db_pass" {
  type      = string
  sensitive = true
}

#db size instance
variable "db_size" {
  type    = string
  default = "db.t3.micro"
}