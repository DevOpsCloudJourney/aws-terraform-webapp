module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source               = "./modules/rds"
  vpc_id               = module.vpc.vpc_id
  db_identifier        = "aws-tf-rds"
  db_instance_class    = "db.t3.micro"
  db_allocated_storage = 20
  db_username          = "admin"
  db_password          = file("password.txt")
  db_name              = "mydatabase"
  db_subnet_group_name = "aws-tf-rds-subnet-group"
  subnet_ids           = [module.vpc.public_subnet_id]
  db_security_group_id = module.security_group.sg_id
}

resource "null_resource" "create_rds_schema" {
  depends_on = [module.rds]

  provisioner "local-exec" {
    command = <<EOT
      mysql -h $(echo ${module.rds.rds_endpoint} | cut -d':' -f1) -P 3306 -u ${module.rds.db_username} -p${module.rds.db_password} -e "
      CREATE DATABASE IF NOT EXISTS ${module.rds.db_name};
      USE ${module.rds.db_name};
      CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL UNIQUE
      );
      INSERT INTO users (name, email) VALUES 
      ('Alice', 'alice@example.com'),
      ('Bob', 'bob@example.com'),
      ('Charlie', 'charlie@example.com');
      SHOW TABLES;
    "
    EOT
  }
}

