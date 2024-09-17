
variable "aws_region" {
    description = "The AWS region to deploy resource in"
    type = string
  }

variable "vpc_cidr" {
  description = "This is a variable for the VPC CIDR block"
}

variable "vpc_name" {
  description = "This is a variable for the VPC name"
}

variable "cidr_public_subnet" {
  description = "CIDR ranges for public subnets"
  type        = list(string)
}

variable "cidr_private_subnet" {
  description = "CIDR ranges for private subnets"
  type        = list(string)
}

variable "us_availability_zone" {
  description = "Availability Zones"
  type        = list(string)
}

variable "instance_type" {
    description = "Type of instance to be created"
 }

variable "ami_id" {
  description = "AMI ID for EC2 instance"
 }

variable "key_name" {
    description = "Name of key pair to access the instance"
  }


