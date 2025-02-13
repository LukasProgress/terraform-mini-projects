output "aws_ec2_public_ip" {
  description = "Public IP of the AWS EC2 instance"
  value       = module.aws_infra.ec2_public_ip
}

output "azure_storage_account" {
  description = "Azure Storage Account Name"
  value       = module.azure_infra.storage_account_name
}
