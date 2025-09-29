
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "cicd-health-dashboard"
}

variable "admin_cidr" {
  description = "CIDR allowed to SSH (your IP)"
  type = string
  default = "0.0.0.0/0"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key to upload to AWS (for key pair)"
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_name" {
  type    = string
  default = "cicddb"
}

variable "db_username" {
  type    = string
  default = "cicduser"
}

variable "db_password" {
  type    = string
  default = "ChangeMe123!"
}
