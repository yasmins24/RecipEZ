#!/bin/bash

response=$(curl -H "Authorization: token $1" \
          https://api.github.com/repos/yasmins24/PickMyMeals/actions/workflows/build.yml/runs?per_page=1 | jq -r '.workflow_runs[0]')
          
status=$(echo $response | jq -r '.status')
conclusion=$(echo $response | jq -r '.conclusion')

echo "conclusion=$conclusion" >> "$GITHUB_OUTPUT"
echo "status=$status" >> "$GITHUB_OUTPUT"
