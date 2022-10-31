terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "GiladYehuda-dev-vpc" {
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "GiladYehuda-dev-vpc"
  }
}

resource "aws_subnet" "GiladYehuda-k8s-subnet" {
  vpc_id     = aws_vpc.GiladYehuda-dev-vpc.id
  cidr_block = "192.168.1.0/27"

  tags = {
    Name = "GiladYehuda-k8s-subnet"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.GiladYehuda-dev-vpc.id

  tags = {
    Name = "gateway"
  }
}

resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.GiladYehuda-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}
