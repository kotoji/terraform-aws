variable "create" {
  type    = bool
  default = true
}

variable "name" {
  type = string
}

variable "default_bucket" {
  type = object({
    bucket = string
    arn    = string
    dir    = string
  })
}

variable "buckets" {
  type = list(object({
    arn = string
    key = string
  }))
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}
