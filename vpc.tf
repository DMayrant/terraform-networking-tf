locals {
  common_tags = {
    Owner       = "Devonne"
    Environment = "Development"
    Project     = "Terraform"

  }
}

resource "aws_vpc" "vpc_network" {
  cidr_block           = "10.122.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "vpc_network"
  })
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc_network.id
  cidr_block = "10.122.2.0/24"


  tags = merge(local.common_tags, {
    Name = local.common_tags.Project
  })

}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_network.id
  cidr_block = "10.122.3.0/24"


  tags = merge(local.common_tags, {
    Name = local.common_tags.Project
  })
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc_network.id

  tags = merge(local.common_tags, {
    Name = "terraform-IGW"
  })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_network.id
  route {
    cidr_block = "0.0.0.0/00"
    gateway_id = aws_internet_gateway.IGW.id
  }


}
resource "aws_route_table_association" "public_subnet" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet.id
}


