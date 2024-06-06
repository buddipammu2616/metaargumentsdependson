#Create a EC2 instance
resource "aws_instance" "maheshec2" {
  ami = "ami-00fa32593b478ad6e"
  instance_type = "t2.micro"
  key_name = "terraform-keypair"
  subnet_id = aws_subnet.maheshpublicsubnet.id
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to StackSimplify ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
     EOF  
  vpc_security_group_ids = [aws_security_group.maheshSG.id]
  #user_data = file("apache-install.sh")
  tags = {
    "Name" = "maheshec2"
  }
}