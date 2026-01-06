data "aws_vpc" "ohio" {
  provider = aws.us-east-2
  filter {
    name   = "tag:Name"
    values = ["ohio_vpc1"] # Adjust if your East-2 VPC name is different
  }
}

data "aws_subnets" "east2_all" {
  provider = aws.us-east-2
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.ohio.id]
  }
}

data "aws_subnet" "east2_details" {
  provider = aws.us-east-2
  for_each = toset(data.aws_subnets.east2_all.ids)
  id       = each.value
}

resource "aws_ec2_transit_gateway" "us_east2_hub" {
  description = "US East2 Hub for VPC peering"
  
  auto_accept_shared_attachments = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  provider = aws.us-east-2

  tags = {
    Name = "us-east2-hub-tgw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1_east2" {
  subnet_ids         = [for az, ids in local.east2_tgw_subnets : ids[0]] 
  transit_gateway_id = aws_ec2_transit_gateway.us_east2_hub.id
  vpc_id             = data.aws_vpc.ohio.id
  provider = aws.us-east-2

  tags = {
    Name = "vpc1-east2-attachment"
  }
}

resource "aws_ec2_transit_gateway_route" "to_east1_tgw" {
  provider                       = aws.us-east-2
  destination_cidr_block         = "10.8.0.0/21" # East-1 CIDR's
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tgw_peering.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.us_east2_hub.propagation_default_route_table_id
  depends_on                     = [aws_ec2_transit_gateway_peering_attachment_accepter.tgw_peering_accepter]
}