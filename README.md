# AWS Infra

Assignment #03 

## Terraform Deployment for Cloud Infrastructure

This Terraform deployment code creates a network infrastructure on a cloud provider using five modules. The code creates a VPC, public and private subnets, an internet gateway, and route tables for the subnets. The deployment code is highly reusable and can be customized to fit different cloud provider configurations.

### Terraform Setup

1. Install Terraform: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)
2. Clone this repository to your local machine.
3. Configure your cloud provider credentials by following the instructions in the cloud provider documentation.
4. Update the variable values in `variables.tf` and `terraform.tfvars` to match your desired configuration.

### Terraform Commands

* `terraform init` - initializes the Terraform configuration and downloads the necessary modules and providers.
* `terraform plan` - shows the planned execution of the Terraform deployment code.(choose dev or demo)
* `terraform apply` - deploys the infrastructure to the cloud provider. You will be prompted to confirm the deployment before it starts.
* `terraform destroy` - destroys the infrastructure on the cloud provider. You will be prompted to confirm the destruction before it starts.

### Modules

#### VPC (`./modules/vpc`)

This module creates a VPC with public and private subnets in the specified availability zones.

#### Public Subnets (`./modules/public_subnets`)

This module creates public subnets for the VPC in the specified availability zones.

#### Private Subnets (`./modules/private_subnets`)

This module creates private subnets for the VPC in the specified availability zones.

#### Internet Gateway (`./modules/internet_gateway`)

This module creates an Internet Gateway for the VPC.

#### Public Route Table (`./modules/public_route_table`)

This module creates a route table for the public subnets and associates it with the Internet Gateway.

#### Private Route Table (`./modules/private_route_table`)

This module creates a route table for the private subnets and associates it with a NAT Gateway, if any.

### Best Practices

The public subnets are each a `/20` block, allowing up to `4,094` IP addresses for each subnet, and the private subnets are each a `/18` block, which allows for a larger number of IP addresses and more potential for additional subnetting. 

CIDR blocks follow the recommended practice of keeping the IP addresses of the public and private subnets separate from each other.