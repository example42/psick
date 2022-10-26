variable "instances" {}

variable "ami_id" {
  type = string
  default = "ami-0729e439b6769d6ab"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "subnet" {}
