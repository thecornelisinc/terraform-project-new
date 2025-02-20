resource "aws_lb" "ELB" {
  name               = "terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public-2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "development"
  }
}

resource "aws_lb_target_group" "tf" {
  name     = "terraform-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}


resource "aws_lb_target_group_attachment" "tf" {
  target_group_arn = aws_lb_target_group.tf.arn
  target_id        = module.webserver-1.webserver_id
  port             = 80
}