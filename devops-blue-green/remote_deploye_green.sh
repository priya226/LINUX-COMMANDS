#!/usr/bin/env bash
set -e

# Deploys a specific JAR version to the GREEN environment on EC2.
# Usage (from CI via SSH):
#   remote_deploy_green.sh my-app-1.2.3.jar https://artifactory/.../my-app-1.2.3.jar

APP_DIR="/app/green"
JAR_NAME="${1:?Jar name required}"     # e.g. my-app-1.2.3.jar
JAR_URL="${2:?Jar URL required}"       # full Artifactory URL

echo "[REMOTE] Deploying $JAR_NAME to GREEN in $APP_DIR"

cd "$APP_DIR"

echo "[REMOTE] Downloading JAR from Artifactory..."
curl -f -O "$JAR_URL"                  # saves as $JAR_NAME in APP_DIR

echo "[REMOTE] Starting Java app..."
nohup java -jar "$JAR_NAME" > app.log 2>&1 &

echo "[REMOTE] App started. Health will be checked by ALB/CI."
