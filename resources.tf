#providers

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

#data
data "aws_availability_zones" "available" {}

#resources
resource "aws_vpc" "vpc" {
	cidr_block = "${var.cidr_block_range}"
	tags {
		"Names" = "${var.environment_tag}-vpc"
		"Environment" = "${var.environment_tag}"
	}
}

resource "aws_internet_gateway" "igw" {
	vpc_id = "${aws_vpc.vpc.id}"
	tags {
		"Names" = "${var.environment_tag}-igw"
		"Environment" = "${var.environment_tag}"
	}
}

resource "aws_subnet" "subnet1" {
	vpc_id = "${aws_vpc.vpc.id}"
	cidr_block = "${var.subnet1_cidr_block_range}"
	map_public_ip_on_launch = "true"
	availability_zone = "${data.aws_availability_zones.available.names[0]}"
	tags {
		"Names" = "${var.environment_tag}-subnet"
		"Environment" = "${var.environment_tag}"
	}
}

resource "aws_route_table" "rtb" {
	vpc_id = "${aws_vpc.vpc.id}"

	route {
    	cidr_block = "0.0.0.0/0"
    	gateway_id = "${aws_internet_gateway.igw.id}"
  	}

  	tags {
		"Names" = "${var.environment_tag}-rtb"
		"Environment" = "${var.environment_tag}"
	}
}

resource "aws_route_table_association" "rta-subnet" {
  subnet_id      = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.rtb.id}"
}

resource "aws_security_group" "http_sg" {
	name = "http_sg"
	vpc_id = "${aws_vpc.vpc.id}"

	# HTTP access from the VPC
	ingress {
		from_port   = 80
    	to_port     = 80
    	protocol    = "tcp"
    	cidr_blocks = ["0.0.0.0/0"]
	}

	# outbound internet access
	egress {
	    from_port   = 0
	    to_port     = 0
	    protocol    = "-1"
	    cidr_blocks = ["0.0.0.0/0"]
	}

	tags {
		"Names" = "${var.environment_tag}-sg"
		"Environment" = "${var.environment_tag}"
	}
}

resource "aws_instance" "testInstance" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.subnet1.id}"
  vpc_security_group_ids = ["${aws_security_group.http_sg.id}"]

   tags {
		"Names" = "${var.environment_tag}-instance"
		"Environment" = "${var.environment_tag}"
	}
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.testInstance.id}"
}