variable "name" {
  type        = string
  description = "Name to be used on all the resources as identifier"
}

variable "cidr" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "A list of availability zones names or ids in the region"
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC"
}

variable "public_subnet_tags" {
  type        = map(string)
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}
