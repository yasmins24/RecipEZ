#!/bin/bash

# Grab auth token and repository name
token=$1
repo=$2

response=$(curl -H -f "Authorization: token $token" \
        https://api.github.com/repos/yasmins24/$repo/actions/workflows/build.yml/runs?per_page=1 | jq -r '.workflow_runs[0]')

if [ $? -ne 0 ]; then
  echo "Getting workflow status for $repo failed with an exit code of: $?"
fi
        
status=$(echo $response | jq -r '.status')
conclusion=$(echo $response | jq -r '.conclusion')

echo "$repo-conclusion=$conclusion" >> "$GITHUB_OUTPUT"
echo "$repo-status=$status" >> "$GITHUB_OUTPUT"

echo $status
echo $conclusion
