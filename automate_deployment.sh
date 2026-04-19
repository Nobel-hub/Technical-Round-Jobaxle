#!/bin/bash

set -e

APP_DIR="/app"
REPO_URL="git@github.com:Nobel-hub/Technical-Round-Jobaxle.git"
BRANCH="main"

echo "Starting deployment..."

if [ -d "$APP_DIR" ]; then
  cd "$APP_DIR"
  git pull origin "$BRANCH"
else
  git clone "$REPO_URL" "$APP_DIR"
  cd "$APP_DIR"
fi

echo "Installing dependencies..."
npm install

echo "Running build..."
npm run build

echo "Restarting application..."
pm2 restart all || pm2 start index.js

echo "Deployment completed successfully."
