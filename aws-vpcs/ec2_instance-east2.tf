data "aws_ami" "linux_ec2_east_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "east_2_ec2" {
  ami           = data.aws_ami.linux_ec2_east_2.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.ohio_vpc1_sn2.id

  tags = {
    Name = "ec2-east2"
  }

  depends_on = [aws_subnet.ohio_vpc1_sn2]
}