resource "aws_vpc" "virginia_vpc" {
  cidr_block       = "10.9.0.0/21"
  instance_tenancy = "default"
  provider = "us-east-2"

  tags = {
    Name = "vpc1-ohio"
  }
}