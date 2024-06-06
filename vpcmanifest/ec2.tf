#Create a EC2 instance
resource "aws_instance" "maheshec2" {
    ami = "ami-00fa32593b478ad6e"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.maheshpublicsubnet.id
    key_name = "terraform-keypair"
    user_data = <<-EOF
     #! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start
sudo systemctl enable httpd
echo "<h1> Hi MAHESH </h1>" > /var/www/html/index.html
EOF
vpc_security_group_ids = [aws_security_group.maheshSG.id]
#iam_instance_profile = "mahesh-user"
 tags = {
  "Name"= "maheshec2"
 }
}
