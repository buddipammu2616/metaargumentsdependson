#Create a EC2 instance
resource "aws_instance" "maheshec2" {
  ami = "ami-00fa32593b478ad6e"
  instance_type = "t2.micro"
  key_name = "terraform-keypair"
  subnet_id = aws_subnet.maheshpublicsubnet.id
  vpc_security_group_ids = [aws_security_group.maheshSG.id]
  user_data = file("apache-install.sh")
}