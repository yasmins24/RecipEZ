#!/bin/bash

# Grab auth token and repository name
token=$1
repo=$2

response=$(curl -H "Authorization: token $token" \
        https://api.github.com/repos/yasmins24/$repo/actions/workflows/build.yml/runs?per_page=1 | jq -r '.workflow_runs[0]')
        
status=$(echo $response | jq -r '.status')
conclusion=$(echo $response | jq -r '.conclusion')

echo "$repo-conclusion=$conclusion" >> "$GITHUB_OUTPUT"
echo "$repo-status=$status" >> "$GITHUB_OUTPUT"
