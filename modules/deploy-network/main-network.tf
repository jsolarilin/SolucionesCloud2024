resource "aws_vpc" "vpc-obligatorio-soluciones-cloud" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-vpc-obligatorio-soluciones-cloud"
  }
}

resource "aws_subnet" "obligatorio-soluciones-cloud-subnet1" {
  vpc_id                  = aws_vpc.vpc-obligatorio-soluciones-cloud.id
  cidr_block              = var.subnet1
  availability_zone       = var.vpc_aws_az1
  map_public_ip_on_launch = "true"
  tags = {
    Name = "terraform-obligatorio-soluciones-cloud-subnet1"
  }
}

resource "aws_subnet" "obligatorio-soluciones-cloud-subnet2" {
  vpc_id                  = aws_vpc.vpc-obligatorio-soluciones-cloud.id
  cidr_block              = var.subnet2
  availability_zone       = var.vpc_aws_az2
  map_public_ip_on_launch = "true"
  tags = {
    Name = "terraform-obligatorio-soluciones-cloud-subnet2"
  }
}
resource "aws_db_subnet_group" "terraform-subnet-group-db" {
  name       = "terraform-subnet-group-db"
  subnet_ids = [
    aws_subnet.obligatorio-soluciones-cloud-subnet2.id,
    aws_subnet.obligatorio-soluciones-cloud-subnet1.id
  ]

  tags = {
    Name = "terraform-obligatorio-db-subnet-group"
  }
}


resource "aws_internet_gateway" "obligatorio-soluciones-cloud-gw" {
  vpc_id = aws_vpc.vpc-obligatorio-soluciones-cloud.id
  tags = {
    Name = "terraform-obligatorio-soluciones-cloud-gw"
  }
}


resource "aws_default_route_table" "obligatorio-soluciones-cloud-route-table" {
  default_route_table_id = aws_vpc.vpc-obligatorio-soluciones-cloud.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.obligatorio-soluciones-cloud-gw.id
  }
  tags = {
    Name = "Contiene el tráfico hacia internet"
  }
}


resource "aws_security_group" "terraform-eks-sg" {
  name        = "terraform-eks-sg"
  description = "Security group for EKS instances managed by Terraform"
  vpc_id      = aws_vpc.vpc-obligatorio-soluciones-cloud.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
   ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-sg"
  }
}

resource "aws_security_group" "terraform-rds-sg" {
  vpc_id      = aws_vpc.vpc-obligatorio-soluciones-cloud.id
  name        = "terraform-rds-sg"
  description = "Allow access to RDS"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}








