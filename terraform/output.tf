output "resource_group_id" {
  description = "Public IP of the main EC2"
  value       = module.ec2_main_server.public_ip
}
