output "sg_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}
