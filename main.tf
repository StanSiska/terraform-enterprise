#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-5a922335
#
# Your subnet ID is:
#
#     subnet-e4f9f89e
#
# Your security group ID is:
#
#     sg-fca96a96
#
# Your Identity is:
#
#     terraform-training-silkworm
#

# Atlas is Terraform/Enterprise - using Consule in background to keep State File 
terraform {
  backend "atlas" {
    name = "StanSiska/training"
  }
}

variable "aws_access_key" {
  type    = "string"
}

variable "aws_secret_key" {
  type    = "string"
}

variable "aws_region" {
  default = "eu-central-1"
}

variable "count_num" {
  default = "3"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

reso,urce "aws_instance" "web" {
  ami                    = "ami-5a922335"
  count                  = "${var.count_num}"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-e4f9f89e"
  vpc_security_group_ids = ["sg-fca96a96"]

  tags {
    Identity = "terraform-training-silkworm"
    Name     = "Web ${count.index+1}/${var.count_num}"
    City     = "Prague"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
