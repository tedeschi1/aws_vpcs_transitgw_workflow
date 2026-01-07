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
  availability_zone = "us-east-2c"

  tags = {
    Name = "ohio_vpc1_sn1"
  }
}

resource "aws_subnet" "ohio_vpc1_sn2" {
  vpc_id     = aws_vpc.ohio_vpc1.id
  cidr_block = "10.9.1.0/24"
  provider = aws.us-east-2
  availability_zone = "us-east-2a"

  tags = {
    Name = "ohio_vpc1_sn2"
  }
}

resource "aws_route" "vpc_east2_route" {
  provider               = aws.us-east-2
  route_table_id         = aws_vpc.virginia_vpc1.main_route_table_id
  destination_cidr_block = "10.8.0.0/21" # Point to East-1 CIDR
  transit_gateway_id     = aws_ec2_transit_gateway.us_east2_hub.id
}

output "ohio_vpc_id" {
  value = aws_vpc.ohio_vpc1.id
}

output "ohio_vpc_sn1_id" {
  value = aws_subnet.ohio_vpc1_sn1.id
}

output "ohio_vpc_sn2_id" {
  value = aws_subnet.ohio_vpc1_sn2.id
}

output "ohio_route_table_id" {
  value = aws_vpc.ohio_vpc1.main_route_table_id
}