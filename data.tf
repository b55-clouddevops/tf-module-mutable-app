# Reads the information from the remote VPC statefile
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "b55-terraform-state"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

# Reads the information from the remote ALB Statefile
data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "b55-terraform-state"
    key    = "alb/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

# Reads the information from the remote DB Statefile
data "terraform_remote_state" "db_subnet_group_name" {
  backend = "s3"
  config = {
    bucket = "b55-terraform-state"
    key    = "databases/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

# fetches the information of the secret
data "aws_secretsmanager_secret" "secrets" {
  name = "robot/secrets"
}

# Fetches the secrets version from the above server
data "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

# Datasource to fetch the info of AMI
data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "b55-ansible-lab-image"
  owners           = ["self"]
}
