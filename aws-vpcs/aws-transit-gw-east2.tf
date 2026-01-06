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
  subnet_ids         = ["subnet-0c15b0f932a069eea", "subnet-073045df8b055adfa"] 
  transit_gateway_id = aws_ec2_transit_gateway.us_east2_hub.id
  vpc_id             = "vpc-0c7804067cd0ddef4"
  provider = aws.us-east-2

  tags = {
    Name = "vpc1-east2-attachment"
  }
}