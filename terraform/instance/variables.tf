variable "region" {
  default = "<REGION_ID>"
}

variable "ami" {
  default = ""
}

variable "vpc_id" {
  default = "<VPC_ID>"
}

variable "subnet_id" {
  default = "<SUBNET_ID>"
}

variable "instance_type" {
  default = "t2.small"
}

variable "tag_name" {
  default = "Minikube-WKS"
}