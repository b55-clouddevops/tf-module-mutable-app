# Installing the applicaiton
resource "null_resource" "app" {
  count               = local.INSTANCE_COUNT

  connection {
    type     = "ssh"
    user     = local.SSH_USERNAME
    password = local.SSH_PASSWORD
    host     = element(local.INSTANCE_PRIVATE_IPS, count.index)
  }

  provisioner "remote-exec" {
    inline = [

    ]
  }
}