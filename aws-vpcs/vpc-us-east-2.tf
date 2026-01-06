resource "aws_vpc" "ohio_vpc1" {
  cidr_block       = "10.9.0.0/21"
  instance_tenancy = "default"
  provider = aws.us-east-2

  tags = {
    Name = "vpc1-ohio"
  }
}