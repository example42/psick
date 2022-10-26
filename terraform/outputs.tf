output "aws_instances" {
  value = module.aws.*.instance_name
}

output "azure_instances" {
  value = module.azure.*.instance_name
}