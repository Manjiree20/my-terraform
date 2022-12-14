resource "aws_instance" "demo_instance" {
  ami           = "ami-0e6329e222e662a52"
  instance_type = "t2.micro"
  key_name = "aws-tf"
  tags = {
    Name = "terraform"
  }
  user_data = <<EOF
#!/bin/bash
useradd manjiree
echo "1pay@123" | passwd --stdin manjiree
chage -d 0 manjiree
systemctl restart sshd
EOF 
  }

