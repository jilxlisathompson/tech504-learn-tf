# create EC2 instance on AWS
# provide cloud provider name: AWS
# which resource to create 
# AMI (amazon machine image) ID: ami-0c1c30571d2dae5c9 (ubuntu 22.04 LTS)
# Instance type: t3.micro 
# DO NOT hard code access_key/ secret_key for cloud provider
# Instance name 
# HCL syntax: {key = value}
# 
provider "aws" {
    region = var.region 
}
# region to create resource/service
resource "aws_instance" "app_instance" {

    ami = var.app_ami_id
    instance_type = var.instance_type
    # Add Public IP 
    associate_public_ip_address = true
    # instance name 
    tags = {
        Name =  var.instance_Name
    }

}
resource "aws_security_group" "tech_sg" {
  name        = "tech504-shakara-tf-allow-port-22-3000-80"
  description = "Allow port 22 from localhost, 3000 and 80 from anywhere"
  vpc_id      = aws_vpc.main.id  # Make sure you have this VPC resource defined elsewhere

  tags = {
    Name = "tech504-shakara-tf-allow-port-22-3000-80"
    ManagedBy = "Terraform"
  }
}

# Allow port 22 from localhost only
resource "aws_vpc_security_group_ingress_rule" "ssh_localhost" {
  security_group_id = aws_security_group.tech_sg.id
  cidr_ipv4         = "127.0.0.1/32"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Allow port 3000 from anywhere
resource "aws_vpc_security_group_ingress_rule" "app_port_3000" {
  security_group_id = aws_security_group.tech_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3000
  to_port           = 3000
  ip_protocol       = "tcp"
}

# Allow port 80 from anywhere
resource "aws_vpc_security_group_ingress_rule" "http_port_80" {
  security_group_id = aws_security_group.tech_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}