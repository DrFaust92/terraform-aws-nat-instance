variable "tags" {
  description = "Map of tags for all resources (that support tags)"
  type        = "map"
}

variable "nat_sg_name" {
  description = "NAT Instance Security Group Name"
}

variable "vpc_id" {
  description = "VPC ID for NAT Security Group"
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = "list"
}

variable "allow_ssh" {
  description = "allow ssh to NAT Instace"
  default     = false
}

variable "ssh_ingress_range" {
  description = "IP Ranges from which it is allowed to SSH NAT Instance"
  type        = "list"
  default     = []
}

variable "instance_type" {
  description = "NAT Instance type"
}

variable "key_name" {
  description = "NAT Instance SSH key name"
}

variable "instance_profile_id" {
  description = "NAT Insatance profile ID"
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = "list"
}

variable "nat_security_groups" {
  description = "Extra Security Groups for NAT Instance"
  type        = "list"
  default     = []
}

variable "azs" {
  description = "List of Availiabillity Zones to use for instnaces"
  type        = "list"
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public ip address to NAT Instance"
  default     = false
}
