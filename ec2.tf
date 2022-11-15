resource "aws_instance" "demo_instance" {
  ami           = "ami-0e6329e222e662a52"
  instance_type = "t2.micro"
  key_name = "aws-tf"
  tags = {
    Name = "terraform"
  }
  user_data = <<EOF
#!/bin/bash
 sudo yum install openscap-scanner -y
 sudo yum install scap-security-guide -y
 sudo ls -1 /usr/share/xml/scap/ssg/content/ssg-*-ds.xml
 sudo oscap info /usr/share/xml/scap/ssg/content/ssg-amzn2-ds.xml
 sudo yum install libreswan -y
 sudo yum install aide -y
 sudo echo "05 4 * * * root /usr/sbin/aide --check" >> /etc/crontab
 sudo /usr/sbin/aide --init
 sudo cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
 sudo /usr/sbin/aide --check
 sudo echo "ClientAliveInterval 900" >> /etc/ssh/sshd_config
 sudo echo " # rotate log files frequency
           daily " >> /etc/logrotate.conf
 sudo echo "INACTIVE=90" >> /etc/default/useradd          
  EOF
  }