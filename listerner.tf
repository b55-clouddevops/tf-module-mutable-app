


# Generates a Random Number in the given range 
resource "random_integer" "priority" {
  min = 100
  max = 500
}

#  Creates a rule in the private loadBalancer listener
resource "aws_lb_listener_rule" "app_rule" {
  count             = var.INTERNAL ? 1 : 0

  listener_arn      = aws_lb_listener.private.*.arn[0]
  priority          = random_integer.priority.result

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  condition {
    host_header {
      values = ["${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_NAME}"]
    }
  }
}