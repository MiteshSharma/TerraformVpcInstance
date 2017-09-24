output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "public_subnets" {
  value = ["${aws_subnet.subnet1.id}"]
}
output "public_route_table_ids" {
  value = ["${aws_route_table.rtb.id}"]
}
output "ec2_eip" {
  value = ["${aws_eip.ip.public_ip}"]
}