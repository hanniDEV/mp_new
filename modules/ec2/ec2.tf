resource "aws_instance" "yamen-ec2" {
  availability_zone = "us-east-1a"
  ami             = data.aws_ami.app_ami.id
  key_name        = "${var.key_name}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${var.sg_name}"]
    user_data         = <<-EOF
#!/bin/bash
sleep 10
sudo apt-get update -y
sudo apt-get install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
  tags = {
    Name = "${var.admin}-ec2"
    iac  = "terraform"
  }
   
 
}

output "ec2_Id" {
  value = aws_instance.yamen-ec2.id
}


data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["099720109477"]
  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic*"]
    }
  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

