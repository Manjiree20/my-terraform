resource "aws_instance" "demo_instance" {
  ami           = "ami-0e6329e222e662a52"
  instance_type = "t2.micro"
  key_name = "aws-tf"
  tags = {
    Name = "terraform"
  }
  user_data = <<EOF
#!/bin/bash
 yum install httpd -y
 echo "Hello Word" > /var/www/html/index.html
 systemctl start httpd
 systemctl enable httpd
 amazon-linux-extras install epel -y
 sudo yum install libreswan -y
 sudo yum install aide -y
 sudo echo "05 4 * * * root /usr/sbin/aide --check" >> /etc/crontab
 sudo /usr/sbin/aide --init
 sudo cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
 sudo /usr/sbin/aide --check
  EOF
  }