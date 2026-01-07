locals {
  east1_tgw_subnets = { for s in data.aws_subnet.east1_details : s.availability_zone => s.id... }
  east2_tgw_subnets = { for s in data.aws_subnet.east2_details : s.availability_zone => s.id... }
}

data "aws_vpc" "virginia" {
  filter {
    name   = "tag:Name"
    values = ["virginia_vpc1"]
  }
}

data "aws_subnets" "east1_all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.virginia.id]
  }
}

data "aws_subnet" "east1_details" {
  for_each = toset(data.aws_subnets.east1_all.ids)
  id       = each.value
}

resource "aws_ec2_transit_gateway" "us_east1_hub" {
  description = "US Hub for VPC peering"
  
  auto_accept_shared_attachments = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name = "us-hub-tgw"
  }

  depends_on = [aws_subnet.virginia_vpc1_sn1, aws.subnet.virginia_vpc1_sn2 ]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1_east1" {
  subnet_ids         = [for az, ids in local.east1_tgw_subnets : ids[0]] 
  transit_gateway_id = aws_ec2_transit_gateway.us_east1_hub.id
  vpc_id             = data.aws_vpc.virginia.id

  tags = {
    Name = "vpc1-east1-attachment"
  }
}

resource "aws_ec2_transit_gateway_route" "to_east2_tgw" {
  destination_cidr_block         = "10.9.0.0/21" # East-2 CIDR's
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tgw_peering.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.us_east1_hub.propagation_default_route_table_id
}