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

resource "aws_default_route_table" "public" {
  default_route_table_id = "${aws_vpc.minikube-wks-vpc.id}"

  route {
    gateway_id = "${aws_internet_gateway.gw.id}"
    cidr_block = "0.0.0.0/0"
  }

  tags {
    Name = "${var.rt_tag}"
  }
}

resource "aws_main_route_table_association" "public" {
  route_table_id = "${aws_route_table.public.id}"
  vpc_id = "${aws_vpc.minikube-wks-vpc.id}"
}