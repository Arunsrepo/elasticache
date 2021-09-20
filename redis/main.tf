provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAWKSSAWIV22STB6RQ"
  secret_key = "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"
}

resource "aws_elasticache_cluster" "my_cluster"{
cluster_id = "demo"
engine = "redis"
node_type = "cache.t2.micro"
port = 6379
num_cache_nodes = 1
parameter_group_name = "default.redis6.x"
}

resource "aws_vpc" "elasticache_vpc"{
 cidr_block = "172.16.0.0/16"
 tags = {
   name = "ec_vpc"
 }
}

resource "aws_subnet" "ec_subnet1" {
  vpc_id            = aws_vpc.elasticache_vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "ec-test1"
  }
}

resource "aws_subnet" "ec_subnet2" {
  vpc_id            = aws_vpc.elasticache_vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "ec-test2"
  }
}

resource "aws_elasticache_subnet_group" "ec_subnet_grp" {
  name       = "ec-test-cache-subnet"
  subnet_ids = ["ec_subnet1", "ec_subnet2"]
}
