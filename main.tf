provider "aws" {
  region     = "eu-west-3"
  access_key = ""
  secret_key = ""
}

variable "subnet_cider_block" {
  description = "subnet cidr block"
  default     = "10.0.10.0/24"
  type        = string
}

variable "vpc_cider_block" {
  description = "vpc cidr block"
  default     = "10.0.0.0/16"
  type        = string
}

variable "environment" {
  description = "deployment environment"
  default     = "development"
  type        = string
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cider_block
  tags       = {
    Name        = var.environment
    Environment = var.environment
  }
}

resource "aws_subnet" "development-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.subnet_cider_block
  availability_zone = "eu-west-3a"
  tags              = {
    Name        = "development-subnet-1"
    Environment = var.environment
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "development-subnet-2" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = "172.31.48.0/20"
  availability_zone = "eu-west-3a"
  tags              = {
    Name        = "dev-subnet-2"
    Environment = var.environment
  }
}

output "dev-subnet-id" {
  value = aws_subnet.development-subnet-1.id
}