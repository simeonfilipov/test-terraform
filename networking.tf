#creating the test VPC
resource "aws_vpc" "staging-vpc" {
  cidr_block = "10.182.0.0/16"
  tags = {
    "name" = "staging-vpc"
  }
}
###### Part 1 - VPC & Subnet #####
#creating staging subnet
resource "aws_subnet" "staging-subnet" {
  vpc_id            = aws_vpc.staging-vpc.id
  cidr_block        = "10.182.10.0/24"
  availability_zone = "eu-central-1a"
  tags = {
    "name" = "Staging"
  }
}
resource "aws_subnet" "staging-subnet2" {
  vpc_id            = aws_vpc.staging-vpc.id
  cidr_block        = "10.182.20.0/24"
  availability_zone = "eu-central-1b"
  tags = {
    name = "staging2"
  }
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.staging-vpc.id
  tags = {
    "name" = "internet-gw"
  }
}
#choosing staging VPC as default for provisioning
/*  data "aws_vpc" "default-vpc" {
  default = true
}

#choosing the subnet
data "aws_subnets" "default-subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default-vpc.id]
  }
} */

##### Part 2 - Security groups for Virtual Machines #####

##Security group virtual machines && rules ##
resource "aws_security_group" "instances" {
  name   = "vm-instance-security-group"
  vpc_id = aws_vpc.staging-vpc.id
}

resource "aws_security_group_rule" "allow-http-in" {
  type              = "ingress"
  security_group_id = aws_security_group.instances.id
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

#### Part 3 - definition of LB && rules ####
resource "aws_lb" "staging-load-balancer" {
  name               = "staging-load-balancer"
  load_balancer_type = "application"
  subnets            = [aws_subnet.staging-subnet.id, aws_subnet.staging-subnet2.id]
  security_groups    = [aws_security_group.alb.id]
}

#route table
resource "aws_route_table" "route1" {
  vpc_id = aws_vpc.staging-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
  tags = {
    "name" = "route-table"
  }
}

resource "aws_route_table" "route2" {
  vpc_id = aws_vpc.staging-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
  tags = {
    "name" = "route-table2"
  }
}

#route table assoc
resource "aws_route_table_association" "route-assoc-subnet1" {
  subnet_id = aws_subnet.staging-subnet.id
  route_table_id = aws_route_table.route1.id
}
resource "aws_route_table_association" "route-assoc-subnet2" {
  subnet_id = aws_subnet.staging-subnet2.id
  route_table_id = aws_route_table.route2.id
}


#security group for the ALB#
resource "aws_security_group" "alb" {
  name = "vms-alb-security-group"
  vpc_id = aws_vpc.staging-vpc.id
}

#allow port 80 for ALB#
resource "aws_security_group_rule" "allow-alb-http-in" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
#allow all ports out on ALB
resource "aws_security_group_rule" "allow-all-alb-out" {
  type              = "egress"
  security_group_id = aws_security_group.alb.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

#listener definition
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.staging-load-balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

#configuring listener on ALB
resource "aws_lb_listener_rule" "instances" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instances.arn
  }
}

#ALB target groups
resource "aws_lb_target_group" "instances" {
  name     = "staging-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.staging-vpc.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

#attachments of VMs to LB
resource "aws_lb_target_group_attachment" "instance-1" {
  target_group_arn = aws_lb_target_group.instances.arn
  target_id        = aws_instance.instance-1.id
  port             = 8080
}
resource "aws_lb_target_group_attachment" "instance-2" {
  target_group_arn = aws_lb_target_group.instances.arn
  target_id        = aws_instance.instance-2.id
  port             = 8080
}
