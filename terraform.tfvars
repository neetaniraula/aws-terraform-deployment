vpc_cidr            = "10.0.0.0/16"
vpc_name            = "aws_terraform_project"
cidr_public_subnet  = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet = ["10.0.3.0/24", "10.0.4.0/24"]
us_availability_zone = ["us-east-1a", "us-east-1b"]
instance_type       = "t2.micro"
ami_id              = "your#ami-0e86e20dae9224db8"
key_name            = "your key name"
aws_region          = "us-east-1"

