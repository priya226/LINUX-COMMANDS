#!/usr/bin/env bash
set -e

# Simple learning flow: build on laptop -> copy to EC2 -> run
# Usage: ./deploy_from_laptop.sh [env]
# Example: ./deploy_from_laptop.sh green

ENV="${1:-green}"                # e.g. blue / green, default green
SERVER="ec2-user@GREEN_IP"       # TODO: replace GREEN_IP
KEY="path/to/key.pem"            # TODO: replace with your key path
JAR="my-app.jar"

REMOTE_DIR="/app/$ENV"                 # /app/blue or /app/green

echo "[LOCAL] Building locally..."
./gradlew clean build                  # Gradle wrapper build
cp build/libs/*.jar "$JAR"             # assumes single jar in build/libs


echo "[LOCAL] Copying JAR to $SERVER:$REMOTE_DIR..."
scp -i "$KEY" "$JAR" "$SERVER:$REMOTE_DIR/$JAR"


echo "[REMOTE] Starting app on $SERVER ($ENV)..."
ssh -i "$KEY" "$SERVER" "
  set -e
  cd /app/$ENV
  nohup java -jar $JAR > app.log 2>&1 &
"

echo "[DONE] Deployed to $ENV. Now switch traffic (LB/nginx) from BLUE to GREEN."
