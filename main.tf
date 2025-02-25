locals {
  service_definition = {
    apiVersion = "v3.0"
    kind       = "service"
    metadata = {
      name        = var.service_name
      displayname = var.display_name ? var.display_name : var.service_name
      owner       = var.team
      description = var.description
      tags = ["team:${var.team}"]
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
    links = [
        var.github_url != null ? {
        name     = "Source Code"
        type     = "repo"
        provider = "github"
        url      = var.github_url
      } : null,
    ]
  }
}

resource "datadog_software_catalog" "service_v3" {
  entity = yamldecode(local.service_definition)
}