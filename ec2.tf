data "template_file" "web-userdata"{
  template = file("install_openscap.sh")
}


resource "aws_instance" "demo_instance" {
  ami           = "ami-0e6329e222e662a52"
  instance_type = "t2.micro"
  key_name = "aws-tf"
  user_data = data.template_file.web-userdata.rendered
tags = {
    Name = "terraform"
  }
}