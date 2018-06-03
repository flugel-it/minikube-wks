provider "aws" {
  region     = "${var.region}"
}

resource "aws_security_group" "minikube-wks" {
  name = "sg-minikube-wks"
  description = "Enable ports to access kubernetes API"

  tags {
    Name = "${var.tag_segurity_group}"
  }
}

resource "aws_instance" "minikube-wks" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = true
  subnet_id = "${var.subnet_id}"

  security_groups = ["${aws_security_group.minikube-wks.id}"]

  tags {
    Name = "${var.tag_instance_name}"
  }
}