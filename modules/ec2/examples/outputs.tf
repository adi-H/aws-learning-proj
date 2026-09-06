output "test_rendered_instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.nginx-vm.instance_id
}
