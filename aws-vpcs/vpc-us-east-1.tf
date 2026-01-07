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

resource "aws_route" "vpc_east1_route" {
  route_table_id         = aws_vpc.virginia_vpc1.main_route_table_id
  destination_cidr_block = "10.9.0.0/21" # East-2 CIDR
  transit_gateway_id     = aws_ec2_transit_gateway.us_east1_hub.id
}

output "virginia_vpc_id" {
  value = aws_vpc.virginia_vpc1.id
}

output "virginia_vpc_sn1_id" {
  value = aws_subnet.virginia_vpc1_sn1.id
}

output "virginia_vpc_sn2_id" {
  value = aws_subnet.virginia_vpc1_sn2.id
}

output "virginia_route_table_id" {
  value = aws_vpc.virginia_vpc1.main_route_table_id
}
