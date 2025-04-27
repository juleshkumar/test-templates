locals {
  constant_linux_instance_tags = {
    Name        = "${var.customer_name}-${var.Environment}-ec2-linux"
    Environment = var.Environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_role" "ec2_ssm_role" {
  name               = "ec2-ssm-role-${var.Environment}-ec2linux"
  description        = "IAM role for EC2 instances with SSM access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
  tags = {
    Name = "EC2-SSM-Role"
  }
}

resource "aws_iam_instance_profile" "ec2_ssm_instance_profile" {
  name = "linux-ec2-ssm-instance-profile-${var.Environment}-ec2linux"
  role = aws_iam_role.ec2_ssm_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_full_access" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_security_group" "securitygroup" {
  name        = "${var.customer_name}-${var.Environment}-ec2linux-sg"
  description = "Default SG to allow traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "ec2linux_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2linux_key" {
  key_name   = "${var.customer_name}-${var.Environment}-ec2linux-keypair"
  public_key = tls_private_key.ec2linux_private_key.public_key_openssh
}

resource "aws_s3_object" "upload_key" {
  bucket        = "terrafrom-testing-bucket-uipl"        
  key           = "${var.Environment}/backend/keys/${var.customer_name}-${var.Environment}-ec2linux-keypair.pem"   
  content       = tls_private_key.ec2linux_private_key.private_key_pem
  content_type  = "application/x-pem-file"

  tags = {
    Name = "${var.customer_name}-${var.Environment}-ec2linux-keypair"
  }
}

resource "aws_instance" "master" {
  ami                         = var.ami
  instance_type               = var.ec2_instance_type
  key_name                    = aws_key_pair.ec2linux_key.key_name
  subnet_id                   = var.private_subnet1
  vpc_security_group_ids      = [aws_security_group.securitygroup.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_ssm_instance_profile.name
  associate_public_ip_address = false

  tags = merge(
    local.constant_linux_instance_tags,
    var.linux_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}
