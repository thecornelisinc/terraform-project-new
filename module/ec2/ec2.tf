
data "aws_ami" "ami" {
  most_recent      = true
  owners           = var.owners
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
  subnet_id = var.subnet_id
  ami           = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  iam_instance_profile = var.iam_instance_profile
  tags = {
    Name = "Webserver 1"
  }
key_name = "terraform"
vpc_security_group_ids = var.security_groups_id
root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.volume_type
}
ebs_block_device {
    device_name = var.device_name
    volume_size = var.ebs_volume_size
    volume_type = var.volume_type
}

}

output "webserver_id" {
  value = aws_instance.web.id
}