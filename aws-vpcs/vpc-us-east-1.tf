data "aws_route_tables" "east1_all" {
  vpc_id   = data.aws_vpc.virginia.id
}

resource "aws_vpc" "virginia_vpc1" {
  cidr_block       = "10.8.0.0/21"
  instance_tenancy = "default"

  tags = {
    Name = "vpc1-virginia"
  }
}

resource "aws_subnet" "virginia_vpc1_sn1" {
  vpc_id     = data.aws_vpc.virginia.id
  cidr_block = "10.8.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "virginia_vpc1_sn1"
  }
}

resource "aws_subnet" "virginia_vpc1_sn2" {
  vpc_id     = data.aws_vpc.virginia.id
  cidr_block = "10.8.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "virginia_vpc1_sn2"
  }
}

resource "aws_route" "vpc_east1_route" {
  route_table_id         = each.value
  destination_cidr_block = "10.9.0.0/21" # East-2 CIDR
  transit_gateway_id     = aws_ec2_transit_gateway.us_east1_hub.id
  for_each               = toset(data.aws_route_tables.east1_all.ids)
}
