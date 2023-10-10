# Creates SPOT Instances 
resource "aws_spot_instance_request" "spot" {
  count                     = var.SPOT_INSTANCE_COUNT

  ami                       = data.aws_ami.ami.image_id
  instance_type             = var.SPOT_INSTANCE_TYPE
  wait_for_fulfillment      = true 
  vpc_security_group_ids    = [aws_security_group.allows_app.id]
  subnet_id                 = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)
  iam_instance_profile      = "b55-admin"

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}

# Creates OD Instance 
resource "aws_instance" "od" {
  count                         = var.OD_INSTANCE_COUNT
  ami                           = data.aws_ami.ami.image_id 
  instance_type                 = var.OD_INSTANCE_TYPE
  vpc_security_group_ids        = [aws_security_group.allows_app.id]
  subnet_id                     = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)
  iam_instance_profile          = "b55-admin"
}


# Creates EC2 TAGS and attahces to the SERVER
resource "aws_ec2_tag" "app_tags" {
  count                         = local.INSTANCE_COUNT

  resource_id                   = element(local.INSTANCE_IDS, count.index)
  key                           = "Name"
  value                         = "${var.COMPONENT}-${var.ENV}"
}

# If this is called by frontend component, then these instances has to be created in the PUBLIC SUBNET. If not, they are supposed to be created on PRIVATE SUBNET.