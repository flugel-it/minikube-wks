resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.minikube-wks-vpc.id}"

  tags {
    Name = "${var.gw_tag}"
  }
}

resource "aws_default_route_table" "route" {
  default_route_table_id = "${aws_vpc.minikube-wks-vpc.id}"

  route {
    egress_only_gateway_id = "${aws_internet_gateway.gw.id}"
    cidr_block = "0.0.0.0/0"
  }

  tags {
    Name = "${var.rt_tag}"
  }
}