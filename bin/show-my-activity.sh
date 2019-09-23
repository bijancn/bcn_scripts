#!/bin/bash

export GITHUB_API="https://github.numberfour.eu/api/v3"
export ORG="server"
export CREDENTIALS="`cat $HOME/githubcredentials`"

curl -u $CREDENTIALS -s -X GET "$GITHUB_API/users/bnejad/events" |
  jq "map(\"\(.created_at) \(.repo.name) \(.type) \(.payload.action) \(.payload.pull_request.url) \")"
  # jq "map(.payload.pull_request.url)"
