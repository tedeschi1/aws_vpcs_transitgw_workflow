resource "aws_vpc" "virginia_vpc" {
  cidr_block       = "10.8.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-oh-transit"
  }
}
