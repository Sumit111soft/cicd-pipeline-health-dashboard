#!/bin/bash
# Install Docker, Docker Compose, git; clone repo and run docker-compose
apt-get update -y
apt-get install -y git curl jq
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu
# Install docker-compose (v2)
apt-get install -y docker-compose-plugin
# Wait for network
sleep 5
# Clone repo (user must set GIT_REPO variable via terraform template or replace below)
GIT_REPO="${git_repo}"
cd /home/ubuntu
if [ ! -d "cicd-pipeline-health-dashboard" ]; then
  sudo -u ubuntu git clone ${GIT_REPO}
fi
cd cicd-pipeline-health-dashboard/src
# Copy example docker-compose if not present
if [ -f docker-compose.yml ]; then
  cd src || true
fi
# Attempt to start using docker compose
sudo -u ubuntu /usr/bin/docker compose up -d --build
