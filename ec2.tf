# Creates SPOT Instances 
resource "aws_spot_instance_request" "spot" {
  count                 = var.SPOT_INSTANCE_COUNT

  ami                   = data.aws_ami.ami.image_id
  instance_type         = var.SPOT_INSTANCE_TYPE
  wait_for_fulfillment  = true 

  tags = {
    Name = "${var.COMPONENT}=${var.ENV}"
  }
}

# Creates OD Instance 
resource "aws_instance" "od" {
  count             = var.OD_INSTANCE_COUNT
  ami               = data.aws_ami.ami.image_id
  instance_type     = var.OD_INSTANCE_TYPE

  tags = {
    Name = "${var.COMPONENT}=${var.ENV}"
  }
}