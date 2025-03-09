variable "project_name" {
  type        = string
  description = "Project name used in resource naming"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet IDs"
}
