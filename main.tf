#defining provider and secret keys from tfvars
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

/* #using vpc as default one
data "aws_vpc" "staging-vpc" {
  default = true
}

#using subnet as default one
data "aws_subnets" "staging-subnet" {
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.staging-vpc.id ]
  }
} */
