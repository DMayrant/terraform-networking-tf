locals {
  ingress_rules = [{
    port        = 80
    description = "Allow HTTP traffic on port 80"
    },
    {
      port        = 443
      description = "Allow HTTPS traffic on port 443"
    },
    {
      port        = 22
      description = "SSH connection to connect to instance"
  }]
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.vpc_network.id


  tags = merge(local.common_tags, {
    Name = "SG"
  })

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}

resource "aws_instance" "web" {
  ami                         = "ami-0360c520857e3138f"
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_config.size
    volume_type           = var.ec2_volume_config.type

  }
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(local.common_tags, {
    Name = "Ubuntu_Web"

  })
}

