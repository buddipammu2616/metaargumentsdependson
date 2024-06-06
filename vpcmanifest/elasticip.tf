#Create Elastic ip
resource "aws_eip" "maheshEIP" {
  instance = aws_instance.maheshec2.id
   domain = "vpc"
  depends_on = [ aws_internet_gateway.maheshIGW ]
}
