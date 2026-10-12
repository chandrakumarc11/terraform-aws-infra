variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_1" {
  type = string
}

variable "public_subnet_2" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}
