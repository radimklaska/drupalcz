#!/bin/sh
#
# Cloud Hook: post-code-deploy
#
# The post-code-deploy hook is run whenever you use the Workflow page to
# deploy new code to an environment, either via drag-drop or by selecting
# an existing branch or tag from the Code drop-down list. See
# ../README.md for details.
#
# Usage: post-code-deploy site target-env source-branch deployed-tag repo-url
#                         repo-type

site="$1"
target_env="$2"
source_branch="$3"
deployed_tag="$4"
repo_url="$5"
repo_type="$6"

# Update
alias=$site.$target_env

# Run updates and import config.
drush @$alias state-set system.maintenance_mode 1 --format=integer
# drush @$alias rr
drush @$alias cr --yes
drush @$alias updb --yes
drush @$alias cim sync --yes
drush @$alias cr --yes
drush @$alias state-set system.maintenance_mode 0 --format=integer
