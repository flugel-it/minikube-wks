provider "aws" {
  region     = "${var.region}"
}

resource "aws_vpc" "minikube-wks-vpc" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_classiclink = false

  tags {
    Name = "${var.vpc_tag}"
  }
}

resource "aws_subnet" "minikube-wks-subnets" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = "${element(data.aws_availability_zones.azs.names, count.index)}"

  vpc_id = "${aws_vpc.minikube-wks-vpc.id}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.subnet_tag}-${count.index+1}"
  }
}