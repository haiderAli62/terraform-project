# Terraform AWS Project

This repository demonstrates a multi-tier AWS infrastructure using Terraform. It includes:
- A custom VPC with public and private subnets
- Autoscaling group for EC2 instances
- An Application Load Balancer

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) installed.
2. AWS credentials configured (`~/.aws/credentials` or environment variables).
3. (Optional) An S3 bucket and DynamoDB table for remote state (see `main.tf`).

## Quickstart

1. Clone the repository.
2. Initialize the Terraform working directory:
   ```bash
   terraform init
