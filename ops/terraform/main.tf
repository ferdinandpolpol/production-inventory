
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "amorens-general"
    key    = "tf-state/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

data "aws_key_pair" "amorens" {
  key_name = "amorens"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "app_server_sg" {
  name        = "AmorenWebAppSG"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami             = "ami-0d07675d294f17973"
  instance_type   = "t2.small"
  security_groups = [aws_security_group.app_server_sg.name]
  key_name        = "amorens"

  tags = {
    Name = "AmorenWebApp"
  }
}

resource "aws_eip" "app_server_eip" {
  instance = aws_instance.app_server.id
}

resource "aws_route53_zone" "amoren_webapp_zone" {
  name = "amorens.ph"
}

resource "aws_route53_record" "app_server_dns" {
  zone_id = aws_route53_zone.amoren_webapp_zone.zone_id
  name    = "sys.amorens.ph"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.app_server_eip.public_ip]
}

resource "aws_route53_record" "app_server_dns_www" {
  zone_id = aws_route53_zone.amoren_webapp_zone.zone_id
  name    = "www.sys.amorens.ph"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.app_server_eip.public_ip]
}

