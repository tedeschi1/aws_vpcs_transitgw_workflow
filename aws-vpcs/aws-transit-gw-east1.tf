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
  subnet_ids         = ["subnet-0fb212c06357f4d21", "subnet-09ce0e87f2c573a7c"] 
  transit_gateway_id = aws_ec2_transit_gateway.us_east1_hub.id
  vpc_id             = "vpc-01bb5a7a020da430f"

  tags = {
    Name = "vpc1-east1-attachment"
  }
}