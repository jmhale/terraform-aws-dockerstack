resource "aws_security_group" "public_access" {
  name        = "${var.project_name}-public"
  description = "Terraform Managed. SG for ${var.project_name} instance."
  vpc_id      = var.vpc_id

  tags = {
    Name       = var.project_name
    Project    = var.project_name
    tf-managed = "True"
  }

  dynamic "ingress" {
    for_each = var.service_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "primary" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = var.ssh_key_id
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = concat([aws_security_group.public_access.id], var.ingress_security_group_id)
  iam_instance_profile   = aws_iam_instance_profile.primary.name

  tags = {
    Name       = var.project_name
    Project    = var.project_name
    tf-managed = "True"
  }
}

resource "aws_eip" "primary" {
  instance = aws_instance.primary.id
  vpc      = true
}
