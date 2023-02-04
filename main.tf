provider "aws" {
  region = "eu-west-3"
}

variable "avail_zone" {}
variable "vpc_cider_block" {}
variable "subnet_cider_block" {}
variable "env_prefix" {}

resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cider_block
  tags       = {
    Name = "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "myapp-subnet-1" {
  vpc_id            = aws_vpc.myapp-vpc.id
  cidr_block        = var.subnet_cider_block
  availability_zone = var.avail_zone
  tags              = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

#resource "aws_route_table" "myapp-route-table" {
#  vpc_id = aws_vpc.myapp-vpc.id
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.myapp-igw.id
#  }
#  tags = {
#    Name : "${var.env_prefix}-rtb"
#  }
#}

resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = aws_vpc.myapp-vpc.id
  tags   = {
    Name : "${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
    Name : "${var.env_prefix}-main-rtb"
  }
}

#resource "aws_route_table_association" "a-rtb-subnet" {
#  subnet_id      = aws_subnet.myapp-subnet-1.id
#  route_table_id = aws_route_table.myapp-route-table.id
#}