variable "region" {
  default = "<REGION>"
}

variable "vpc_tag" {
  default = "<VPC_TAG_NAME>"
}

variable "subnet_tag" {
  default = "<SUBNET_TAG_NAME>"
}

variable "gw_tag" {
  default = "<GATEWAY_TAG_NAME>"
}

variable "rt_tag" {
  default = "<ROUTE_TABLE_TAG_NAME>"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type = "list"
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "ami" {
  # Change It
  default = "ami-71a4d30e"
}

variable "instance_type" {
  default = "t2.micro"
}

data "aws_availability_zones" "azs" {

}