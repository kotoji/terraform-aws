variable "identifier" {
  type        = string
  description = "The identifier"
}

variable "admin_user_password" {
  type      = string
  sensitive = true
}

variable "default_dbname" {
  type = string
}

variable "iam_roles" {
  type = list(string)
}

variable "base_capacity" {
  type    = number
  default = 8
}
variable "max_capacity" {
  type    = number
  default = 8
}

variable "publicly_accessible" {
  type = bool
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}
