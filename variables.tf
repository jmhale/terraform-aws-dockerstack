variable "ami_id" {
  default = "ami-07ebfd5b3428b6f4d"
}

variable "project_name" {
  default = "docker-stack"
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "ssh_key_id" {
}

variable "vpc_id" {
}

variable "ingress_security_group_id" {
  type = list(string)
}

variable "env" {
  default     = "prod"
  description = "The name of environment. Used to differentiate multiple deployments"
}

variable "service_ports" {
  type    = list(string)
  default = ["80", "443"]
}

variable "boot_scriptz" {
  default = ""
}