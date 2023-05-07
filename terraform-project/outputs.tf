output "public_ip" {
  value = module.ec2-instance-1.public_ip
}

output "private_ip" {
  value = module.ec2-instance-1.private_ip
}
