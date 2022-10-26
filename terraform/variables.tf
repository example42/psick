variable "enable_aws" {
  description = "Enable / Disable AWS Deployment"
  type        = bool
  default     = true
}

variable "enable_azure" {
  description = "Enable / Disable Azure Deployment"
  type        = bool
  default     = false
}

variable "instance_count" {
  description = "Number of Instances"
  type        = string
  default     = 2
}

variable "aws_subnet" {
  description = "AWS Subnet"
  type        = string
  default     = "subnet-01e0d908d980f33cc"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "1-a46ba6a8-playground-sandbox"
}

variable "resource_group_location" {
  description = "Resource Group Location"
  type        = string
  default     = "centralus"
}