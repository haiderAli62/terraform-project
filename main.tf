terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terrafrom-stage-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# --------------------
# VPC Module
# --------------------
module "vpc" {
  source         = "./modules/vpc"
  project_name   = var.project_name
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

# --------------------
# ALB Module
# --------------------
module "alb" {
  source          = "./modules/alb"
  project_name    = var.project_name
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
}

# --------------------
# EC2 Autoscaling Group Module
# --------------------
module "ec2_asg" {
  source            = "./modules/ec2_asg"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  private_subnets   = module.vpc.private_subnets
  alb_target_group_arn = module.alb.alb_target_group_arn

  instance_type     = var.instance_type
  key_name          = var.key_name
  desired_capacity  = var.desired_capacity
  max_capacity      = var.max_capacity
  alb_sg_id         = var.alb_sg_id
}