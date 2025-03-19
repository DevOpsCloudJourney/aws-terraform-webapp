output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "sg_id" {
  description = "The ID of the security group"
  value       = module.security_group.sg_id
}

output "rds_instance_id" {
  description = "ID of the RDS instance"
  value       = module.rds.rds_instance_id
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
}