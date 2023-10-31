variable "aws_region" {
  description = "The AWS region where the resources will be created."
  default     = "ap-south-1"
}

variable "instance_ami" {
  description = "The ID of the Amazon Machine Image (AMI) for instances."
  default     = "ami-0287a05f0ef0e9d9a"
}

variable "instance_type" {
  description = "The EC2 instance type for the instances."
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the EC2 key pair to use for SSH access"
  default     = "prd01" # Change as needed
}
