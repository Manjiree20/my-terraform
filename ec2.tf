resource "aws_instance" "demo_instance" {
  ami           = "ami-0e6329e222e662a52"
  instance_type = "t2.micro"
  key_name = "aws-tf"
  user_data = <<-EOF
 #!/bin/bash
 sudo amazon-linux-extras install epel -y
 sudo yum install openscap-scanner -y
 sudo yum install scap-security-guide -y
 sudo ls -1 /usr/share/xml/scap/ssg/content/ssg-*-ds.xml
 sudo oscap info /usr/share/xml/scap/ssg/content/ssg-amzn2-ds.xml
 sudo oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_pci-dss --results-arf arf.xml --report $HOSTNAME-report.html  /usr/share/xml/scap/ssg/content/ssg-amzn2-ds.xml
EOF
tags = {
    Name = "terraform"
  }
}