provider "aws" {
  region     = "eu-west-3"
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = {
    Name = "development"
  }
}

resource "aws_subnet" "development-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "eu-west-3a"
  tags              = {
    Name = "development-subnet-1"
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = "172.31.48.0/20"
  availability_zone = "eu-west-3a"
  tags              = {
    Name = "dev-subnet-2"
  }
}