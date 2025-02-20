variable "owners" {
  type = list(string)
  default = ["amazon"]
}



variable "iam_instance_profile" {
  type = string
}

variable "instance_type" {}
variable "volume_type" {}
variable "root_volume_size" {}
variable "ebs_volume_size" {}
variable "device_name" {}
variable "subnet_id" {}
variable "security_groups_id" {
  
}