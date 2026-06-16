#!/bin/bash

APP=$1
BRANCH=$2
SITE=$3
ENV=$4

CONFIG="/opt/deployment/config/bench-map.json"

BENCH_PATH=$(cat $CONFIG | jq -r ".${ENV}")

echo "Environment: $ENV"
echo "Bench Path: $BENCH_PATH"

# Step 1: Backup
bash /opt/deployment/scripts/backup.sh "$SITE"

# Step 2: Go to app
cd "$BENCH_PATH/apps/$APP"

# Step 3: Git operations
git fetch origin
git checkout "$BRANCH"
git pull origin "$BRANCH"

# Step 4: Frappe deploy
cd "$BENCH_PATH"

bench --site "$SITE" migrate
bench build
bench clear-cache

# Step 5: Restart
supervisorctl restart all

echo "Deployment SUCCESS"
