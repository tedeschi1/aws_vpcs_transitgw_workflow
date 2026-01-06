resource "aws_vpc" "ohio_vpc1" {
  cidr_block       = "10.9.0.0/21"
  instance_tenancy = "default"
  provider = aws.us-east-2

  tags = {
    Name = "vpc1-ohio"
  }
}

resource "aws_subnet" "ohio_vpc1_sn1" {
  vpc_id     = aws_vpc.ohio_vpc1.id
  cidr_block = "10.9.0.0/24"
  provider = aws.us-east-2

  tags = {
    Name = "ohio_vpc1_sn1"
  }
}

resource "aws_subnet" "ohio_vpc1_sn2" {
  vpc_id     = aws_vpc.ohio_vpc1.id
  cidr_block = "10.9.1.0/24"
  provider = aws.us-east-2

  tags = {
    Name = "ohio_vpc1_sn2"
  }
}