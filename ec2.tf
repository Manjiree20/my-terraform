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
sudo echo "# rotate log files frequency
           daily " >> /etc/logrotate.conf
sudo echo "INACTIVE=90" >> /etc/default/useradd  
sudo echo "server 2.amazon.pool.ntp.org" >> /etc/chrony.conf
sudo echo "server 0.amazon.pool.ntp.org" >> /etc/chrony.conf
sudo yum erase 'ntp*'
sudo yum install chrony -y
sudo echo "server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4" >> /etc/chrony.conf
sudo service chronyd restart
sudo chkconfig chronyd on
chronyc sources -v
chronyc tracking    
sudo echo "GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=VolGroup/LogVol06 rd.lvm.lv=VolGroup/lv_swap rhgb quiet rd.shell=0 audit=1"" >> /etc/default/grub 
  EOF
  }