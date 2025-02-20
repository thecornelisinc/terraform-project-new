module "webserver-1" {
  source               = "./module/ec2"
  instance_type        = "t2.micro"
  device_name          = "/dev/sdf"
  iam_instance_profile = "NetworkingWorkShopEC2Role"
  root_volume_size     = 8
  ebs_volume_size      = 10
  volume_type          = "gp3"
  subnet_id = aws_subnet.private-1.id
  security_groups_id = [aws_security_group.allow_tls.id]
}

output "webserver_id" {
  value = module.webserver-1.webserver_id
}

module "webserver-2" {
  source               = "./module/ec2"
  instance_type        = "t2.micro"
  device_name          = "/dev/sdq"
  iam_instance_profile = "Adminaccecss"
  root_volume_size     = 8
  ebs_volume_size      = 100
  volume_type          = "gp3"
  subnet_id = "subnet-08b6d0a3e341a30ea"
  security_groups_id = ["sg-01ff59b119ef42bc3"]
}

