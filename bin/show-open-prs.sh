#!/bin/bash

export GITHUB_API="https://srv-git-01-hh1.alinghi.tipp24.net/api/v3"

function show-open-prs () {
  curl -s -X GET "$GITHUB_API/search/issues?q=state:open+org:hpo+no:label+is:pr" \
  | jq ".items | map(\"\(.title) by \(.user.login)\",.html_url)[]" | awk 'NR%2{printf "`%-90s `",$0;next;}1'
}

function show-open-prs-that-need-review () {
  curl -s -X GET "$GITHUB_API/search/issues?q=state:open+org:hpo+no:label+is:pr+review:required" \
  | jq ".items | map(\"\(.title) by \(.user.login)\",.html_url)[]" | awk 'NR%2{printf "`%-90s `",$0;next;}1'
}

function show-open-prs-that-are-approved () {
  curl -s -X GET "$GITHUB_API/search/issues?q=state:open+org:hpo+no:label+is:pr+review:approved" \
  | jq ".items | map(\"\(.title) by \(.user.login)\",.html_url)[]" | awk 'NR%2{printf "`%-90s `",$0;next;}1'
}

function show-open-prs-that-requested-changes () {
  curl -s -X GET "$GITHUB_API/search/issues?q=state:open+org:hpo+no:label+is:pr+review:changes_requested" \
  | jq ".items | map(\"\(.title) by \(.user.login)\",.html_url)[]" | awk 'NR%2{printf "`%-90s `",$0;next;}1'
}

function show-open-prs-ordered () {
  echo "PRs that need review: :eyes:"
  show-open-prs-that-need-review
  echo
  echo "PRs that are approved: :white_check_mark:"
  show-open-prs-that-are-approved
  echo
  echo "PRs for which changes have been requested: :construction:"
  show-open-prs-that-requested-changes
}

show-open-prs-ordered
