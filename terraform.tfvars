db_name              = "terraform"
instance_class       = "db.t3.micro"
iam_instance_profile = "NetworkingWorkShopEC2Role"
instance_type        = "t2.micro"
volume_type          = "gp3"
root_volume_size     = 8
ebs_volume_size      = 10
device_name          = "/dev/sdf"