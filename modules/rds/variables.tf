variable "db_identifier" {
  description = "The RDS instance identifier"
  type        = string
  default     = "aws-tf-rds"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the initial database"
  type        = string
  default     = "mydatabase"
}

variable "db_subnet_group_name" {
  description = "Subnet group name for RDS"
  type        = string
  default     = "aws-tf-rds-subnet-group"
}

variable "subnet_ids" {
  description = "List of subnet IDs for RDS"
  type        = list(string)
}

variable "db_security_group_id" {
  description = "Security group ID for RDS instance"
  type        = string
}

variable "rds_subnet_a_cidr" {
  description = "CIDR block for the first RDS subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "rds_subnet_b_cidr" {
  description = "CIDR block for the second RDS subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}
