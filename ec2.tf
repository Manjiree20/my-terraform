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
 yum install openscap-scanner -y
 yum install scap-security-guide -y
 ls -1 /usr/share/xml/scap/ssg/content/ssg-*-ds.xml
 oscap info /usr/share/xml/scap/ssg/content/ssg-amzn2-ds.xml
 oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_pci-dss --results-arf arf.xml --report $HOSTNAME-report.html  /usr/share/xml/scap/ssg/content/ssg-amzn2-ds.xml
  EOF
  }