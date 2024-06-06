#Create Elastic ip
resource "aws_eip" "maheshEIP" {
  instance = aws_instance.maheshec2.id
  vpc = true
  depends_on = [ aws_internet_gateway.maheshIGW ]
}
