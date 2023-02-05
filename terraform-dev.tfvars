cider_block = [
  { cidr_block = "10.0.0.0/16", name = "dev-vpc" },
  { cidr_block = "10.0.50.0/24", name = "development-subnet-1" },
  { cidr_block = "172.31.48.0/20", name = "development-subnet-2" }
]

environment = "development"