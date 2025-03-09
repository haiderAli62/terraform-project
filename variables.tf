variable "project_name" {
  type        = string
  description = "Project name used in resource naming"
  default     = "my-terraform-project"
}

variable "aws_region" {
  type        = string
  description = "AWS Region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type        = list(string)
  description = "List of CIDRs for private subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the Autoscaling Group"
  default     = "t3.micro"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instances in the autoscaling group"
  default     = 2
}

variable "max_capacity" {
  type        = number
  description = "Maximum number of instances in the autoscaling group"
  default     = 4
}

variable "key_name" {
  type        = string
  description = "EC2 Key pair name"
  default     = "my-key"
}

variable "alb_sg_id" {
  type        = string
  description = "Security group ID for the ALB"
  default     = "sg-s35463dgggfdgd345"
}
