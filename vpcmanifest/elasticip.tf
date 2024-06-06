#Create Elastic ip
resource "aws_eip" "maheshEIP" {
  instance = aws_instance.maheshec2.id
   domain = Vpc
  depends_on = [ aws_internet_gateway.maheshIGW ]
}
