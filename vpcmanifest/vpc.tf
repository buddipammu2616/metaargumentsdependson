#Create a Vpc
resource "aws_vpc" "maheshvpc" {
    cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "maheshvpc"
  }
}
#Create a subnet
resource "aws_subnet" "maheshpublicsubnet" {
    cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.maheshvpc.id
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}
#Create a Internet Gate Way
resource "aws_internet_gateway" "maheshIGW" {
  vpc_id = aws_vpc.maheshvpc.id
}#Create a Route Table
resource "aws_route_table" "maheshRT" {
  vpc_id = aws_vpc.maheshvpc.id
  tags = {
    "Name" = "Mahesh Internet Gateway"
  }
}
#Create a Route in Route Table for Internet Access
resource "aws_route" "maheshR" {
  route_table_id = aws_route_table.maheshRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.maheshIGW.id
}
#Create the Route table with subnet
resource "aws_route_table_association" "maheshRTSassociation" {
  route_table_id = aws_route_table.maheshRT.id
  subnet_id = aws_subnet.maheshpublicsubnet.id
}
#Create a Security Group
resource "aws_security_group" "maheshSG" {
  name = "maheshSG"
  description = "Mahesh Security Group"
  vpc_id = aws_vpc.maheshvpc.id

  #specify Inbound Rule for port 22
  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  #Specify inbound rule for port 80
  ingress {
    description      = "Allow port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}
#Specify Outbound rules
egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}