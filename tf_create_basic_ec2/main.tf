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
    region = "eu-west-1" 
}
# region to create resource/service
resource "aws_instance" "app_instance" {

    ami = "ami-0c1c30571d2dae5c9"
    instance_type = "t3.micro"
    # Add Public IP 
    associate_public_ip_address = true
    # instance name 
    tags = {
        Name = "tech504-shakara-tf-test-app"
    }

}

