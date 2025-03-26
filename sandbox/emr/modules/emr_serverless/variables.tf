variable "create" {
  type    = bool
  default = true
}

variable "name" {
  type = string
}

variable "buckets" {
  type = list(object({
    arn = string
    key = string
  }))
}

variable "studio_role_arns" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}
