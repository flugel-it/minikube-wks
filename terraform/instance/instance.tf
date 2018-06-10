provider "aws" {
  region     = "${var.region}"
}

resource "aws_security_group" "minikube-wks" {
  name = "sg_minikube_wks"
  description = "Enable ports to access kubernetes API"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enable SSH port on inbound"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description = "Enable all access outbound"
  }

  tags {
    Name = "${var.tag_name}"
  }
}

resource "aws_instance" "minikube-wks" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = true
  subnet_id = "${var.subnet_id}"

  security_groups = ["${aws_security_group.minikube-wks.id}"]

  tags {
    Name = "${var.tag_name}"
  }
}