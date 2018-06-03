provider "aws" {
  region     = "${var.region}"
}

resource "aws_instance" "minikube-wks" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"

  tags {
    Name = "Minikube-WKS"
  }
}