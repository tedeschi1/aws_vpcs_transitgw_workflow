resource "aws_ec2_transit_gateway" "us_east1_hub" {
  description = "US Hub for VPC peering"
  
  auto_accept_shared_attachments = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name = "us-hub-tgw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1_east1" {
  subnet_ids         = [ aws_subnet.virginia_vpc1_sn1.id, aws_subnet.virginia_vpc1_sn2.id ] 
  transit_gateway_id = aws_ec2_transit_gateway.us_east1_hub.id
  vpc_id             = aws_vpc.virginia_vpc1.id

  tags = {
    Name = "vpc1-east1-attachment"
  }
}

resource "aws_ec2_transit_gateway_route" "to_east2_tgw" {
  destination_cidr_block         = "10.9.0.0/21" # East-2 CIDR's
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tgw_peering.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.us_east1_hub.propagation_default_route_table_id
}