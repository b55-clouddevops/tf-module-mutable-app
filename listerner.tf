# This creates the listener and adds to the private ALB
resource "aws_lb_listener" "private" {
  count             = var.INTERNAL ? 1 : 0

  load_balancer_arn = data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ARN 
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}