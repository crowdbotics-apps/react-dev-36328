#!/bin/bash

set -euo pipefail

# Script based on https://altinukshini.wordpress.com/2019/01/09/circleci-notifications-in-rocketchat/

url="https://$WEBHOOK_HOSTNAME/api/v1/github-repos/$PROJECT_ID/circleci_webhook/"

payload=$(
cat <<EOM
{
    "status": "$1",
    "job": "$CIRCLE_JOB",
    "build_num": "$CIRCLE_BUILD_NUM",
    "repo": "$CIRCLE_REPOSITORY_URL",
    "branch": "$CIRCLE_BRANCH",
    "build_url": "$CIRCLE_BUILD_URL",
    "compare_url": "$CIRCLE_COMPARE_URL",
    "sha1": "$CIRCLE_SHA1",
    "platform_id": "$PLATFORM_ID"
}
EOM
)

curl -X POST -H "Content-Type: application/json" -H "Authorization: Api-Key $WEBHOOK_API_KEY" --data "$payload" $url
echo "Webhook call completed"
