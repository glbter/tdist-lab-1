provider "aws" {
  region  = "eu-north-1"
  profile = "my-project-profile"
}

locals {
  user_data = <<-EOT
        #! /bin/bash

        curl -o /root/ec2-startup-script.sh -OL https://github.com/DanikVitek/tdist-lab-1/raw/refs/heads/prometheus_grafana/terraform/ec2-startup-script.sh
        chmod +x /root/ec2-startup-script.sh
        bash /root/ec2-startup-script.sh
    EOT

  ami_id    = var.ami_id
  ami_owner = var.ami_owner
  vpc_id    = var.vpc_id
  ebs_id    = var.ebs_id

  ssh_public_key = var.ssh_public_key

  az = "eu-north-1a"

  tags = {
    terraform = "true"
  }
}


# SG
module "sg_main_server" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "sg_main_server"
  description = "Security group to allow access to the main server"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = [
    "http-80-tcp",
    "ssh-tcp",
    "grafana-tcp",
    "prometheus-http-tcp",
  ]

  # egress_rules = ["http-80-tcp"]

  vpc_id = local.vpc_id

  tags = local.tags
}


resource "aws_subnet" "vpc_subnet" {
  vpc_id     = local.vpc_id
  cidr_block = "10.0.0.0/24"

  availability_zone = local.az

  map_public_ip_on_launch = true

  tags = local.tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = local.tags
}

resource "aws_route_table" "rt" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = local.tags
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.vpc_subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_key_pair" "main_server_key" {
  key_name   = "key for TDIST lab1_2"
  public_key = local.ssh_public_key
  tags       = local.tags
}

data "aws_ami" "arm" {
  most_recent = true
  owners      = [local.ami_owner]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["tdist-lab-1"]
  }
}

# EC2
module "ec2_main_server" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "main_server"

  ami               = data.aws_ami.arm.id
  instance_type     = "t4g.micro"
  availability_zone = local.az
  key_name          = aws_key_pair.main_server_key.key_name

  subnet_id = aws_subnet.vpc_subnet.id

  vpc_security_group_ids = [module.sg_main_server.security_group_id]

  associate_public_ip_address = true

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  tags = local.tags
}


resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = local.ebs_id

  instance_id = module.ec2_main_server.id
}
