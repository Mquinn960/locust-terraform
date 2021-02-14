resource "aws_vpc" "locust_demo_net" {

  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = var.project_tag
  }
}