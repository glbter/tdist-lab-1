variable "ami_id" {
  type        = string
  description = "AWS AMI ID"
}

variable "ami_owner" {
  type        = string
  description = "AWS AMI owner"
}

variable "vpc_id" {
  type        = string
  description = "ID of the AWS VPC"
}

variable "ebs_id" {
  type        = string
  description = "ID of persistant EBS storage for prometheus metrics"
}

variable "ssh_public_key" {
  type        = string
  description = "The RSA public key for SSH"
}
