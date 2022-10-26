output "instance_name" {
  value = aws.inst.*.tags.Name
}