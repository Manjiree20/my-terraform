resource "aws_instance" "demo_instance" {
  ami           = "ami-0e6329e222e662a52"
  instance_type = "t2.micro"
  key_name = "terraform.pem"
  user_data = <<EOF
#!/bin/bash
sudo yum install httpd -y
echo "Hello Word" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
EOF
}