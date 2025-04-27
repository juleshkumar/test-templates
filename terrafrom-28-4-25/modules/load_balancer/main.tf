locals {
  constant_alb_tags = {
    Environment = var.Environment
    ManagedBy   = "Terraform"
  }
}
resource "aws_lb" "vrt_load_balancer" {
  name                       = "${var.customer_name}-${var.Environment}-alb"
  internal                   = var.internal
  load_balancer_type         = "application"
  enable_deletion_protection = false
  security_groups            = [aws_security_group.tf-sg.id]
  subnets                    = var.public_subnet_ids
    tags = merge(
    local.constant_alb_tags,
    var.lb_tags
  )
}


resource "aws_lb_listener" "lis443" {
  load_balancer_arn = aws_lb.vrt_load_balancer.arn
  port              = var.listener-port
  protocol          = var.listener-protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn

  }
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.customer_name}-${var.Environment}-target-group"
  port     = var.target-group-port
  protocol = var.target-gorup-protocol
  vpc_id   = var.vpc_id
  health_check {
    path                = "/healthz"  # Set your custom health check path
    protocol            = "HTTP"      # Health check protocol (usually HTTP or HTTPS)
    interval            = 30          # Optional: Interval in seconds between health checks
    timeout             = 5           # Optional: Time in seconds to wait for a health check response
    healthy_threshold   = 3           # Optional: Number of consecutive successful checks before considering the target healthy
    unhealthy_threshold = 2           # Optional: Number of consecutive failed checks before considering the target unhealthy
  }
}

resource "aws_security_group" "tf-sg" {
  vpc_id      = var.vpc_id
  name        = "${var.customer_name}-${var.Environment}-alb-sg"
  description = "security group for alb"

    ingress {
    description = "Allow HTTP traffic from within the VPC"
    from_port   = var.target-group-port
    to_port     = var.target-group-port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# uncomment this when you have a existing autoscalng group 

#resource "aws_autoscaling_attachment" "test" {
#  autoscaling_group_name = var.autoscaling-group-name
#  lb_target_group_arn   = aws_lb_target_group.tg.arn
#}
