# Creates SPOT Instances 
resource "aws_spot_instance_request" "spot" {
  count                     = var.SPOT_INSTANCE_COUNT

  ami                       = data.aws_ami.ami.image_id
  instance_type             = var.SPOT_INSTANCE_TYPE
  wait_for_fulfillment      = true 
  vpc_security_group_ids    = [aws_security_group.allows_app.id]

  tags = {
    Name = "${var.COMPONENT}=${var.ENV}"
  }
}

# Creates OD Instance 
resource "aws_instance" "od" {
  count             = var.OD_INSTANCE_COUNT
  ami               = data.aws_ami.ami.image_id 
  instance_type     = var.OD_INSTANCE_TYPE
  vpc_security_group_ids    = [aws_security_group.allows_app.id]

  tags = {
    Name = "${var.COMPONENT}=${var.ENV}"
  }
}