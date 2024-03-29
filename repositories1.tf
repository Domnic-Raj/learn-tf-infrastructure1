# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Create infrastructure repository
resource "github_repository" "infrastructure1" {
  name = "learn-tf-infrastructure1"
}

# Add memberships for infrastructure repository
resource "github_team_repository" "infrastructure1" {
  for_each = {
    for team in local.repo_teams_files["infrastructure"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.infrastructure.id
  permission = each.value.permission
}

# Create application repository
resource "github_repository" "application1" {
  name = "learn-tf-application1"
}

# Add memberships for application repository
resource "github_team_repository" "application1" {
  for_each = {
    for team in local.repo_teams_files["application"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.application.id
  permission = each.value.permission
}
