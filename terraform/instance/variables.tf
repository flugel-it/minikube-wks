variable "region" {
  default = "us-west-2"
}

variable "ami" {
  type = "map"
  default = {
    us-west-2 = "ami-59443326"
  }
}

variable "instance_type" {
  default = "t2.micro"
}