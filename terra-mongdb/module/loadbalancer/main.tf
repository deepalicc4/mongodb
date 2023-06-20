resource "aws_lb" "ALB" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  //security_groups    = [var.lbsg]
  security_groups    = [var.lbsg1]
  subnets            = [var.sub1 , var.sub2]
  enable_deletion_protection = false

    tags = {
    Environment = "test"
    }
}
resource "aws_lb_target_group" "my-tg" {
  name     = "nginx-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpclb
}

resource "aws_lb_target_group" "my-tg2" {
  name     = "tomcat-target"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpclb
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-tg.arn
  }
  }

#   resource "aws_lb_target_group_attachment" "tg-attach" {
#   target_group_arn = aws_lb_target_group.my-tg.arn
#   target_id        = var.ami-id
#   port             = 80
# }