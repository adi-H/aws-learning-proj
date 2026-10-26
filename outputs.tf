# ec2 public ip 
# output "public_ip" {
#   description = "Public IP address (if assigned)"
#   value       = module.nginx-vm.public_ip
# }
output "app_url" {
  value = "http://${module.networking.alb_dns_name}"
}
