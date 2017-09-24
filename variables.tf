# Variables

variable "access_key" {
    default = ""
}
variable "secret_key" {
    default = ""
}
variable "region" {
  default = "us-east-1"
}
variable "cidr_block_range" {
  default = "10.1.0.0/16"
}
variable "subnet1_cidr_block_range" {
  default = "10.1.0.0/24"
}
variable "environment_tag" {
  default = "QA"
}