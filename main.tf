provider "aws" {
  region = "eu-west-3"
}

variable "avail_zone" {
  description = "availability zone"
  default     = "eu-west-3a"
}

variable "cider_block" {
  description = "subnet cidr block"
  type        = list(object({
    cidr_block = string
    name       = string
  }))
}

variable "environment" {
  description = "deployment environment"
  default     = "development"
  type        = string
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.cider_block[0].cidr_block
  tags       = {
    Name        = var.cider_block[0].name
    Environment = var.environment
  }
}

resource "aws_subnet" "development-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.cider_block[1].cidr_block
  availability_zone = var.avail_zone
  tags              = {
    Name        = var.cider_block[1].name
    Environment = var.environment
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "development-subnet-2" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = var.cider_block[2].cidr_block
  availability_zone = var.avail_zone
  tags              = {
    Name        = var.cider_block[2].name
    Environment = var.environment
  }
}
