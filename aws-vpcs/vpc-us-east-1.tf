resource "aws_vpc" "virginia_vpc1" {
  cidr_block       = "10.8.0.0/21"
  instance_tenancy = "default"

  tags = {
    Name = "vpc1-virginia"
  }
}

resource "aws_subnet" "virginia_vpc1_sn1" {
  vpc_id     = aws_vpc.virginia_vpc1.id
  cidr_block = "10.8.0.0/24"

  tags = {
    Name = "virginia_vpc1_sn1"
  }
}

resource "aws_subnet" "virginia_vpc1_sn2" {
  vpc_id     = aws_vpc.virginia_vpc1.id
  cidr_block = "10.8.1.0/24"

  tags = {
    Name = "virginia_vpc1_sn2"
  }
}
