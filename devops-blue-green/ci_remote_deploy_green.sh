#!/usr/bin/env bash
set -e

# Simplified CI step: tell Green EC2 to deploy a specific version from Artifactory.

# Normally these come from CI variables / parameters:
VERSION="1.2.3"
JAR_NAME="my-app-$VERSION.jar"
JAR_URL="https://artifactory.example.com/repo/$JAR_NAME"

GREEN_SERVER="ec2-user@GREEN_IP"       # TODO: replace
KEY="path/to/key.pem"                  # TODO: replace

echo "[CI] Deploying version $VERSION to GREEN: $GREEN_SERVER"

ssh -i "$KEY" "$GREEN_SERVER" \
  "/app/remote_deploy_green.sh $JAR_NAME $JAR_URL"

echo "[CI] Green deploy triggered."
echo "[CI] Next (usually automated by CI / AWS):"
echo "  1) Wait for Green ALB target group to be healthy."
echo "  2) Switch ALB listener from Blue TG -> Green TG."
echo "  3) Monitor and optionally scale down Blue."
