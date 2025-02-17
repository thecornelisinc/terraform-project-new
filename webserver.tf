
data "aws_ami" "ami" {
  most_recent      = true
  owners           = ["amazon"]
 
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
 
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
 
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
 
}
resource "aws_instance" "web" {
  subnet_id = aws_subnet.private-1.id
  ami           = data.aws_ami.ami.image_id
  instance_type = "t2.micro"

  tags = {
    Name = "Webserver 1"
  }
key_name = "terraform"
vpc_security_group_ids = [aws_security_group.allow_tls.id]
root_block_device {
    volume_size = 8
    volume_type = "gp3"
}
ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 10
    volume_type = "gp3"
}
}



