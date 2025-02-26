locals {
  service_definition = {
    apiVersion = "v3"
    kind       = "service"
    metadata = {
      name        = var.service_name
      displayName = var.display_name != null ? var.display_name : var.service_name
      owner       = var.team_name
      description = var.description
      tags = ["team:${var.team_name}"]
      links = [
          var.github_url != null ? {
          name     = "Source Code"
          type     = "repo"
          provider = "github"
          url      = var.github_url
        } : null,
      ]
    }
    #     contacts = [
    #       {
    #         name = "Support Email"
    #         type = "email"
    #         contact = var.support_email
    #       },
    #     ]
    #     tier = var.tier
    #     application = var.application
    #     languages = var.languages
    #     type = var.type
  }
}

resource "datadog_software_catalog" "service_v3" {
  entity = yamlencode(local.service_definition)
}