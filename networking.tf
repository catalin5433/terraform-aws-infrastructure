resource "aws_vpc" "main" {  

   
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "DevOps-Project-vpc1"
  }
}


# the first subnet which is public
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet1"
  }
}


# the second subnet which is private
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private_subnet1"
  }
}


# the internet gateway 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = { 
    Name = "DevOps-Project-igw1"
  }
}


# the route table of the public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
  tags = {
    Name = "DevOps-Project-rtb-public1"
  }
}

# association between the above route table and the public subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


# the route table of the private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

    tags = {
      Name = "DevOps-Project-rtb-private1"
  }

}

# association between the above route table and the private subnet
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}




# the security group
resource "aws_security_group" "main" {
  name        = "allow_http_https_ssh"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_http_https_ssh"
  }
}

# egress rule
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.main.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "-1"
  ip_protocol = "-1" # semantically equivalent to all ports
  to_port     = "-1"
}

# ingress rule http port 80
resource "aws_vpc_security_group_ingress_rule" "http_80_ipv4" {
  security_group_id = aws_security_group.main.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "80"
  ip_protocol = "tcp"
  to_port     = "80"
}


# ingress rule https port 443
resource "aws_vpc_security_group_ingress_rule" "https_443_ipv4" {
  security_group_id = aws_security_group.main.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "443"
  ip_protocol = "tcp"
  to_port     = "443"
}


# ingress rule TCP ports 8080-8100
resource "aws_vpc_security_group_ingress_rule" "TCP_range_ipv4" {
  security_group_id = aws_security_group.main.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "8080"
  ip_protocol = "tcp"
  to_port     = "8100"
}

#currently not used
data "http" "myip" {
  url = "https://checkip.amazonaws.com/"
}


# ingress rule ssh from my ip only
resource "aws_vpc_security_group_ingress_rule" "ssh_from_my_ip" {
  security_group_id = aws_security_group.main.id

  cidr_ipv4   = "${var.my_public_ip}/32"
  from_port   = "22"
  ip_protocol = "tcp"
  to_port     = "22"
}

