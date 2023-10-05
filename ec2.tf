# Creates SPOT Instances 

resource "aws_spot_instance_request" "spot" {
  count                 = var.SPOT_INSTANCE_COUNT

  ami                   = data.aws_ami.ami.image_id
  spot_price            = "0.03"
  instance_type         = var.SPOT_INSTANCE_TYPE
  wait_for_fulfillment  = true 

  tags = {
    Name = "CheapWorker"
  }
}