variable "service_name" {
  description = "The name of the service. A group of function names can be part of the same service"

  type = string
}

variable "display_name" {
  description = "The display name of the service. A user friendly name for the service"

  default = null
  type    = string
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

variable "support_email" {
  description = "The email address for support to this service"

  default = null
  type    = string
}

variable "slack_url" {
  description = "The slack URL for support to this service"

  default = null
  type    = string
}

variable "team_name_override" {
  description = "Override the team name tag for Datadog. If set, this will override the value from the SSM parameter."
  type        = string
  default     = null
}
