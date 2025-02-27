data "aws_ssm_parameter" "team_name" {
  name = "/__platform__/team_name_handle"
}

locals {
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

  filtered_contacts = [for contact in local.contacts : contact if contact != null]

  service_metadata = {
    name        = var.service_name
    displayName = var.display_name != null ? var.display_name : var.service_name
    owner       = data.aws_ssm_parameter.team_name.value
    description = var.description

    tags = ["team:${data.aws_ssm_parameter.team_name.value}"]
    links = [
      var.github_url != null ? {
        name     = "Source Code"
        type     = "repo"
        provider = "github"
        url      = var.github_url
      } : null,
    ]
  }

  service_definition = {
    apiVersion = "v3"
    kind       = "service"
    metadata   = length(tolist(local.filtered_contacts)) > 0 ? merge(local.service_metadata, { contacts = local.filtered_contacts }) : local.service_metadata
  }
}

resource "datadog_software_catalog" "service_v3" {
  entity = yamlencode(local.service_definition)
}
