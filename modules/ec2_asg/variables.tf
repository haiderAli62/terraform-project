variable "project_name" {
  type        = string
  description = "Project name used in resource naming"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "Key pair name"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instances"
}

variable "max_capacity" {
  type        = number
  description = "Maximum number of instances"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "alb_target_group_arn" {
  type        = string
  description = "ARN of the ALB target group"
}

variable "alb_sg_id" {
  type        = string
  description = "Id of the security group for the ALB"
}


