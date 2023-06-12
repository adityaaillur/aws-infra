# AWS Infra

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

Command to import Certificate: "aws acm import-certificate --certificate fileb://certificate.crt --private-key fileb://private.key --region us-east-1 --profile demo"

# AWS Setup

This repository contains the code and configuration for setting up a CI/CD pipeline for an application on AWS.

## Application Overview

- Node.js application with APIs for user account creation, product management, and image uploads.
- Implemented authorization and authentication using basic auth with the bcrypt library.

## Infrastructure Setup

The infrastructure is provisioned using Terraform and Packer. Here are the key components:

### Network Setup

- Created a Virtual Private Cloud (VPC) with public and private subnets in different availability zones.
- Configured internet and NAT gateways for connectivity.
- Set up public and private route tables for routing traffic.

### Continuous Integration

- Utilized GitHub Actions for continuous integration.
- Unit tests run automatically when a pull request is raised.
- Packer builds are validated before merging the pull request.

### Continuous Deployment

- Created Amazon Machine Images (AMIs) using Packer for application setup.
- Implemented automatic instance refresh in the Auto Scaling group to deploy new AMIs.

### Security Groups

- Application Security Group: Allows inbound traffic for SSH (port 22) and application (port 3000) from the Load Balancer Security Group.
- Load Balancer Security Group: Allows inbound traffic on port 443 (HTTPS).
- Database Security Group: Allows inbound traffic on port 3306 (MySQL).

### Load Balancer

- Configured a load balancer to accept HTTPS traffic on port 443 and forward it to the application instances.
- Applied an SSL certificate obtained from ZeroSSL via AWS Certificate Manager.

### Autoscaling

- Created a launch template to define EC2 instance configurations.
- Implemented dynamic scaling based on CPU utilization using CloudWatch metrics.

### DNS Service

- Registered a domain name with Namecheap.
- Configured AWS Route 53 for DNS management, including subdomains for dev and demo environments.

### RDS (Relational Database Service)

- Created an RDS instance in a private subnet group.
- Enabled encryption using AWS Key Management Service (KMS).
- Restricted public accessibility.

### S3 (Simple Storage Service)

- Created a private S3 bucket with server-side encryption (AES256).
- Configured a lifecycle policy to transition objects from STANDARD to STANDARD_IA storage class after 30 days.
- Defined an IAM policy for EC2 to access S3 buckets with limited permissions.

### AMI (Amazon Machine Image)

- Built custom AMIs using Packer, based on Amazon Linux 2.
- The AMIs are private and shared between the dev and demo environments.
- Setup script included to configure the application and dependencies in the AMI.

### Logging & Metrics

- Implemented logging using the Winston library, with logs stored in the var/log folder.
- Metrics and monitoring set up using StatsD and CloudWatch, installed and configured in the Packer setup script.

## Getting Started

To get started with the application, follow the steps below:

1. Set up the AWS environment using the provided Terraform configuration.
2. Configure the GitHub Actions workflows for CI/CD.
3. Access the application using the provided domain name.

For detailed instructions, please refer to the [wiki](https://github.com/your-repo/wiki).
