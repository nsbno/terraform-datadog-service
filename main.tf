data "aws_ssm_parameter" "team_name" {
  count = var.team_name_override == null ? 1 : 0

  name = "/__platform__/team_name_handle"
}

locals {
  team_name = var.team_name_override != null ? var.team_name_override : data.aws_ssm_parameter.team_name[0].value

  service_definition = {
    apiVersion = "v3"
    kind       = "service"
    metadata = {
      name        = var.service_name
      displayName = var.display_name != null ? var.display_name : var.service_name
      owner       = local.team_name
      description = var.description
      tags        = ["team:${local.team_name}"]
      links = [
        var.github_url != null ? {
          name     = "Source Code"
          type     = "repo"
          provider = "github"
          url      = var.github_url
        } : null,
      ]
      contacts = [
        var.support_email != null ? {
          name    = "Support Email"
          type    = "email"
          contact = var.support_email
        } : null,
        var.slack_url != null ? {
          name    = "Support Slack"
          type    = "slack"
          contact = var.slack_url
        } : null,
      ]
    }

  }
}

resource "datadog_software_catalog" "service_v3" {
  entity = yamlencode(local.service_definition)
}
