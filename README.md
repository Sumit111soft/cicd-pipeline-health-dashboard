# CI/CD Pipeline Health Dashboard

## Overview
A dashboard to collect and visualize GitHub Actions pipeline metrics and alert on failures.

## Technology Stack
Backend: Python 3.11+
Frontend: React with Vite and Tailwind CSS
Database: PostgreSQL
Deployment: Containerized setup using Docker
Alerting: Slack Webhooks

## Quick start (development)
1. Copy `.env` files and fill values (GITHUB_TOKEN, SLACK_WEBHOOK_URL) if you plan to connect GitHub/Slack.
Ensure all varibales have been updated with the actual values to run the project at its fullest.
2. Run: `docker compose up --build`
Run above command to build and create docker images using docker-compose file.
Validate the running containers using "docker ps" command.
3. Frontend: Hit http://localhost:5173 on browser to see frontend/UI portal.
4. Backend API (FastAPI): Hit http://localhost:8000/docs on browser to locate FastAPI portal for Swagger purposes.

## Seeder / Demo data
A small seeder is included (`src/backend/seed_data.py`) to populate demo pipeline runs so the UI shows data after first start.
