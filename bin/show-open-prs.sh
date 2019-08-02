#!/bin/bash

export GITHUB_API="https://github.numberfour.eu/api/v3"
export ORG="server"
export ORG2="NumberFour"
export USER="bnejad"
export CREDENTIALS="`cat $HOME/githubcredentials`"

function show-open-prs () {
  curl -u $CREDENTIALS -s -X GET "$GITHUB_API/search/issues?q=state:open+user:$USER+no:label+is:pr" \
    # | jq ".items | map(\"\(.title) by \(.user.login)\",.html_url)[]" | awk 'NR%2{printf "`%-90s `",$0;next;}1'
}

function show-open-prs-that-need-review () {
  curl -u $CREDENTIALS -s -X GET "$GITHUB_API/search/issues?q=state:open+org:$ORG+no:label+is:pr+review:required" \
    | jq ".items | map(\"\(.title) by \(.user.login)\",.html_url)[]" | awk 'NR%2{printf "`%-90s `",$0;next;}1'
}

function show-open-prs-that-are-approved () {
  curl -u $CREDENTIALS -s -X GET "$GITHUB_API/search/issues?q=state:open+org:$ORG+no:label+is:pr+review:approved" \
    | jq ".items | map(\"\(.title) by \(.user.login)\",.html_url)[]" | awk 'NR%2{printf "`%-90s `",$0;next;}1'
}

function show-open-prs-that-requested-changes () {
  curl -u $CREDENTIALS -s -X GET "$GITHUB_API/search/issues?q=state:open+org:$ORG+no:label+is:pr+review:changes_requested" \
    | jq ".items | map(\"\(.title) by \(.user.login)\",.html_url)[]" | awk 'NR%2{printf "`%-90s `",$0;next;}1'
}

function show-open-prs-ordered () {
  echo "All PRs: "
  show-open-prs
  echo
  echo "PRs that need review: :eyes:"
  show-open-prs-that-need-review
  echo
  echo "PRs that are approved: :white_check_mark:"
  show-open-prs-that-are-approved
  echo
  echo "PRs for which changes have been requested: :construction:"
  show-open-prs-that-requested-changes
}

show-open-prs
