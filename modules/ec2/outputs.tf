output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.vm.id
}

output "private_ip" {
  description = "Private IP address of the instance"
  value       = aws_instance.vm.private_ip
}

output "public_ip" {
  description = "Public IP address (if assigned)"
  value       = aws_instance.vm.public_ip
}

output "security_group_id" {
  description = "sg id of the ec2 instance"
  value       = aws_security_group.sg.id

}