data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc"  "sample_vpc"{
cidr_block="${var.vpc_cidr}"
tags = {
    name = "myVPC"
  }
}
resource "aws_subnet" "public-sub"{
cidr_block="10.0.0.192/26"
vpc_id="${aws_vpc.sample_vpc.id}"
availability_zone="us-east-1a"
}

resource "aws_internet_gateway" "igw"{
vpc_id="${aws_vpc.sample_vpc.id}"
}

resource "aws_route_table" "rtbl"{
vpc_id="${aws_vpc.sample_vpc.id}"
route{
cidr_block="0.0.0.0/0"
gateway_id="${aws_internet_gateway.igw.id}"
}
}

resource "aws_route_table" "rtbl1"{
vpc_id="${aws_vpc.sample_vpc.id}"
route{
cidr_block="0.0.0.0/0"
gateway_id="${aws_nat_gateway.gw.id}"
}
}

resource "aws_route_table_association" "pubrtbl"{
subnet_id="${aws_subnet.public-sub.id}"
route_table_id="${aws_route_table.rtbl.id}"
}
resource "aws_route_table_association" "pubrtb2"{
subnet_id="${aws_subnet.subnet1.id}"
route_table_id="${aws_route_table.rtbl1.id}"
}
resource "aws_route_table_association" "pubrtb3"{
subnet_id="${aws_subnet.subnet2.id}"
route_table_id="${aws_route_table.rtbl1.id}"
}
resource "aws_route_table_association" "pubrtb4"{
subnet_id="${aws_subnet.subnet3.id}"
route_table_id="${aws_route_table.rtbl1.id}"
}
resource "aws_subnet" "subnet1"{
vpc_id="${aws_vpc.sample_vpc.id}"
cidr_block="${var.prvt_subnet1_cidr}"
availability_zone="${data.aws_availability_zones.available.names[0]}"
tags = {
    name = "SUBNET1"
  }
}

resource "aws_subnet" "subnet2"{
vpc_id="${aws_vpc.sample_vpc.id}"
cidr_block="${var.prvt_subnet2_cidr}"
availability_zone="${data.aws_availability_zones.available.names[1]}"
tags = {
    name = "SUBNET2"
  }
}

resource "aws_subnet" "subnet3"{
vpc_id="${aws_vpc.sample_vpc.id}"
cidr_block="${var.prvt_subnet3_cidr}"
availability_zone="${data.aws_availability_zones.available.names[0]}"
tags = {
    name = "SUBNET3"
  }
}

/*resource "aws_subnet" "subnet4"{
vpc_id="${aws_vpc.sample_vpc.id}"
cidr_block="${var.prvt_subnet4_cidr}"
availability_zone="${data.aws_availability_zones.available.names[1]}"
tags = {
    name = "SUBNET4"
  }
}*/
 
resource "aws_eip" "nat" {
  vpc=true
  }
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public-sub.id}"

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_security_group" "sgrp2" {
  name="sgrp2"
  vpc_id = "${aws_vpc.sample_vpc.id}"
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }
   ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
 from_port=5985
 to_port=5985
 protocol="tcp"
 cidr_blocks=["0.0.0.0/0"]
}
  ingress{
 from_port=5986
 to_port=5986
 protocol="tcp"
 cidr_blocks=["0.0.0.0/0"]
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "SECURITYGRP2"
}
}

resource "aws_security_group" "sgrp1"{
name="sgrp1"
vpc_id="${aws_vpc.sample_vpc.id}"
 ingress{
 from_port=3389
 to_port=3389
 protocol="tcp"
 cidr_blocks=["0.0.0.0/0"]
}
 ingress{
 from_port=5985
 to_port=5985
 protocol="tcp"
 cidr_blocks=["0.0.0.0/0"]
}
   ingress{
 from_port=5986
 to_port=5986
 protocol="tcp"
 cidr_blocks=["0.0.0.0/0"]
}
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    name = "SECURITYGRP1"
}
}





