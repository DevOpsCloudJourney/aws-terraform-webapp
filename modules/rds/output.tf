output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.rds_instance.id
}

output "rds_subnet_a_id" {
  description = "ID of the first RDS subnet"
  value       = aws_subnet.rds_subnet_a.id
}

output "rds_subnet_b_id" {
  description = "ID of the second RDS subnet"
  value       = aws_subnet.rds_subnet_b.id
}

output "db_username" {
  description = "The master username for the RDS instance"
  value       = var.db_username
}

output "db_password" {
  description = "The master password for the RDS instance"
  value       = var.db_password
}

output "db_name" {
  description = "The name of the initial database"
  value       = var.db_name
}
