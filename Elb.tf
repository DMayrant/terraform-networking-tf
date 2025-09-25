resource "aws_lb" "app_lb" {
  name                       = "Net-lb"
  internal                   = false
  load_balancer_type         = "network"
  security_groups            = [aws_security_group.main.id]
  subnets                    = [aws_subnet.public_subnet.id]
  enable_deletion_protection = true


  tags = merge(local.common_tags, {
    Name = "Net_Lb"
  })
}

resource "aws_lb_target_group" "lb_ec2_tg" {
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc_network.id

  tags = merge(local.common_tags, {
    Environment = "Production"

  })
}

resource "aws_lb_listener" "alb_listener" {

  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_ec2_tg.arn


  }

}

