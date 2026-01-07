data "aws_route_tables" "east2_all" {
  vpc_id   = data.aws_vpc.ohio.id
}

resource "aws_vpc" "ohio_vpc1" {
  cidr_block       = "10.9.0.0/21"
  instance_tenancy = "default"
  provider = aws.us-east-2

  tags = {
    Name = "vpc1-ohio"
  }
}

resource "aws_subnet" "ohio_vpc1_sn1" {
  vpc_id     = data.aws_vpc.ohio_vpc1.id
  cidr_block = "10.9.0.0/24"
  provider = aws.us-east-2
  availability_zone = "us-east-2c"

  tags = {
    Name = "ohio_vpc1_sn1"
  }
}

resource "aws_subnet" "ohio_vpc1_sn2" {
  vpc_id     = data.aws_vpc.ohio_vpc1.id
  cidr_block = "10.9.1.0/24"
  provider = aws.us-east-2
  availability_zone = "us-east-2a"

  tags = {
    Name = "ohio_vpc1_sn2"
  }
}

resource "aws_route" "vpc_east2_route" {
  provider               = aws.us-east-2
  for_each               = toset(data.aws_route_tables.east1_all.ids)
  route_table_id         = each.value
  destination_cidr_block = "10.8.0.0/21" # Point to East-1 CIDR
  transit_gateway_id     = aws_ec2_transit_gateway.us_east2_hub.id
}