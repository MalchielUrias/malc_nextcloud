variable "name" {
  default = "nc"
}

variable "tags" {
  default = {
    "environment" = "prod",
    "project" = "nexcloud"
  }
}

variable "ami" {
  default = "ami-0d64bb532e0502c46"
}

variable "wp_type" {
  default = "t2.micro"
}
variable "sg_description" {
  default = "NextCloud Site Security Group"
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "instance_profile" {
  type = string
}

variable "key_name" {
  type = string
}