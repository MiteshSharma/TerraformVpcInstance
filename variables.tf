# Variables

variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "cidr_block_range" {
  description = "The CIDR block for the VPC"
  default = "10.1.0.0/16"
}
variable "subnet1_cidr_block_range" {
  description = "The CIDR block for the subnet of VPC"
  default = "10.1.0.0/24"
}
variable "environment_tag" {
  description = "Environment tag"
  default = "QA"
}