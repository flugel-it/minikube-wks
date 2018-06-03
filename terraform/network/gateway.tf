resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.minikube-wks-vpc.id}"

  tags {
    Name = "${var.gw_tag}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.minikube-wks-vpc.id}"

  route {
    gateway_id = "${aws_internet_gateway.gw.id}"
    cidr_block = "0.0.0.0/0"
  }

  tags {
    Name = "${var.rt_tag}"
  }
}