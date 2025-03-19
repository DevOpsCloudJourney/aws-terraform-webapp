resource "aws_internet_gateway" "aws_tg" {
  vpc_id = var.vpc_id

  tags = {
    Name = "aws-tf-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_tg.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_route_table_assoc_a" {
  subnet_id      = aws_subnet.rds_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_assoc_b" {
  subnet_id      = aws_subnet.rds_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "rds_subnet_a" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "aws-tf-rds-subnet-a"
  }
}

resource "aws_subnet" "rds_subnet_b" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "aws-tf-rds-subnet-b"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = [aws_subnet.rds_subnet_a.id, aws_subnet.rds_subnet_b.id]

  tags = {
    Name = var.db_subnet_group_name
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier             = var.db_identifier
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  storage_type           = "gp2"
  username               = var.db_username
  password               = var.db_password
  db_name                = var.db_name
  publicly_accessible    = true
  multi_az               = false
  vpc_security_group_ids = [var.db_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot    = true

  tags = {
    Name = var.db_identifier
  }
}
