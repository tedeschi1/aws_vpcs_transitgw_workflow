resource "aws_vpc" "virginia_vpc1" {
  cidr_block       = "10.8.0.0/21"
  instance_tenancy = "default"

  tags = {
    Name = "vpc1-virginia"
  }
}
