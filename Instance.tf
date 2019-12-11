provider "aws" {
	region="eu-west-2"
}

resource "aws_instance" "Ansible_Server" {
ami = "ami-040ba9174949f6de4"
instance_type = "t2.small"
subnet_id = "${aws_subnet.Ansible_Server_SubnetLinux.id}"
vpc_security_group_ids = ["${aws_security_group.Ansible_SecurityGroup.id}"]
key_name = var.key_name

tags = {
Name = "Ansible_Controller"
}

}

resource "aws_instance" "Ansible_Server" {
ami = "ami-040ba9174949f6de4"
instance_type = "t2.small"
subnet_id = "${aws_subnet.Ansible_Server_SubnetLinux.id}"
vpc_security_group_ids = ["${aws_security_group.Ansible_SecurityGroup.id}"]
key_name = var.key_name

tags = {
Name = "Ansible_1"
}

}

resource "aws_instance" "Ansible_Server" {
ami = "ami-040ba9174949f6de4"
instance_type = "t2.small"
subnet_id = "${aws_subnet.Ansible_Server_SubnetLinux.id}"
vpc_security_group_ids = ["${aws_security_group.Ansible_SecurityGroup.id}"]
key_name = var.key_name

tags = {
Name = "Ansible_2"
}

}

resource "aws_vpc" "Ansible_Server_VPC" {
  cidr_block = "10.0.0.0/16"

    tags = {
    Name = "Ansible_Server_VPC"
  }
}
 

resource "aws_internet_gateway" "Ansible_Server_IGWLinux" {
  vpc_id = "${aws_vpc.Ansible_Server_VPC.id}"
 
  tags = {
    Name = "Ansible_Server__IGWLinux"
  }
}
 
resource "aws_subnet" "Ansible_Server_SubnetLinux" {
  vpc_id            = "${aws_vpc.Ansible_Server_VPC.id}"
  availability_zone = "eu-west-2a"
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

    tags = {
    Name = "Ansible_Server_SubnetLinux"
  }
}

resource "aws_route_table" "Public_RT_Ansible_Linux"{
vpc_id = "${aws_vpc.Ansible_Server_VPC.id}"
route{
cidr_block = "0.0.0.0/0"
gateway_id = "${aws_internet_gateway.Ansible_Server_IGWLinux.id}"
}
tags = {
Name = "Public_RT_Ansible_Linux"
}
}
 
resource "aws_route_table_association" "PublicSubnet_Association_Linux" {
  subnet_id      = "${aws_subnet.Ansible_Server_SubnetLinux.id}"
  route_table_id = "${aws_route_table.Public_RT_Ansible_Linux.id}"
}

resource "aws_security_group" "Ansible_SecurityGroup" {
    name = "Ansible_SecurityGroup"
    description = "Allow incoming connections from Internet and SSH"
    vpc_id = "${aws_vpc.Ansible_Server_VPC.id}"

    ingress { 
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${"0.0.0.0/0"}"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${"14.98.201.90/32"}"]
    }
    
    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

   tags = {
       
        Name= "Ansible_SecurityGroup"
    }
}