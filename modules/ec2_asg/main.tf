resource "aws_security_group" "asg_sg" {
  name        = "${var.project_name}-asg-sg"
  description = "Security group for EC2 ASG"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [var.alb_sg_id] 
    cidr_blocks      = []            
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-asg-sg"
  }
}

resource "aws_launch_template" "this" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>${var.project_name} is running on $(hostname)</h1>" > /var/www/html/index.html
              EOF

  security_group_names = [aws_security_group.asg_sg.name]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-instance"
    }
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_autoscaling_group" "this" {
  name                = "${var.project_name}-asg"
  max_size            = var.max_capacity
  min_size            = 1
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.private_subnets
  health_check_type   = "EC2"
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  target_group_arns = [var.alb_target_group_arn]
  lifecycle {
    create_before_destroy = true
  }

}
