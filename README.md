AWS Terraform Deployment Project
Project Overview
This project demonstrates the setup of AWS infrastructure using Terraform, including the creation of a VPC with public and private subnets, Internet Gateway, NAT Gateway, and Route Table configurations.

Prerequisites
Terraform: Install Terraform on your local machine.
AWS CLI: Install AWS CLI and configure it with your AWS credentials (aws configure).
Git: Ensure Git is installed and configured on your system.

Setup Instructions:
Initialize Terraform: Before deploying, initialize Terraform to download the necessary provider plugins:
terraform init
Review and Modify Variables (Optional): Open variables.tf to review and modify any variables, such as VPC CIDR blocks, subnet sizes, and region, to fit your specific requirements.

Plan the Deployment: Run a Terraform plan to see the changes that will be made. This step is crucial to understand what resources will be created:
terraform plan

Deploy the Infrastructure: Deploy the infrastructure using Terraform apply. You will be prompted to confirm the action by typing yes:
terraform apply

Verify the Deployment: After deployment, log in to your AWS Management Console to verify that all resources have been created as expected (VPC, subnets, gateways, route tables).

Destroy the Infrastructure (Optional): To clean up all resources and avoid any AWS charges, you can destroy the infrastructure by running:
terraform destroy

Project Components:
main.tf: Main configuration file for creating AWS resources.
variables.tf: Defines input variables for customizing the deployment.
provider.tf: AWS provider configuration.
outputs.tf: Displays the output values after deployment, such as VPC ID and subnet IDs.
Notes
Ensure your AWS credentials are properly configured and have sufficient permissions to create and manage the required AWS resources.
Modify the configurations as needed to match your network design and security requirements.







