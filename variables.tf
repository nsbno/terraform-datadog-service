variable "service_name" {
  description = "The name of the service. A group of function names can be part of the same service"

  type = string
}

variable "team" {
  description = "The team that owns the service"

  type = string
}

variable "description" {
  description = "The description of the service"

  default = ""
  type    = string
}

variable "github_url" {
  description = "The URL to the source code repository in GitHub"

  default = null
  type    = string
}
