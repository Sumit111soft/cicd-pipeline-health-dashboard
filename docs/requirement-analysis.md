# Requirement Analysis — CI/CD Pipeline Health Dashboard

## 1. Overview
The goal is to develop a **production-grade, containerized dashboard** that provides visibility into CI/CD workflows running on GitHub Actions.  
The system should present key metrics like build success/failure rates, average build duration, and latest build status, along with build logs and automated failure alerts (via Slack or email).  
The complete setup should be deployable using Docker, and the project should include a section describing how AI contributed to the solution development.

---

## 2. Stakeholders
- **DevOps Engineers** — primary maintainers and users.
- **Developers** — to monitor their code pipelines.
- **SRE / Platform Teams** — for operational visibility.
- **Project Managers** — for build health insights.

---

## 3. Objectives & Key Outcomes
- Enable near real-time insights into CI/CD executions.
- Provide automatic notifications for failing pipelines.
- Offer a lightweight deployment process (`docker-compose up`).
- Maintain complete documentation and an AI activity log.

**Success Indicators:**
- Metrics update automatically without manual triggers.
- Alerts are configurable and delivered promptly.
- Deployment runs consistently across environments.

---

## 4. Metrics to be Captured
- Pipeline success rate (daily / weekly / monthly).
- Average workflow duration by repository, branch, or workflow.
- Latest build status and timestamp.
- Count and ratio of failed executions.
- Recent build logs (limit configurable, searchable).

---

## 5. Data Sources & Integrations
- **GitHub Actions API (v3/v4)** — to retrieve workflow run data and logs.
- **GitHub Webhooks (optional)** — for event-driven updates.
- **Slack Webhook / SMTP or SendGrid** — to send failure notifications.

---

## 6. Non-Functional Requirements
- **Containerized setup:** Deploy with Docker Compose.
- **Configurable:** All secrets and parameters defined via environment variables (e.g., GitHub tokens, Slack webhook, DB connection).
- **Security:** No hardcoded credentials; secrets must remain external.
- **Scalability:** Backend services should remain stateless with persistent data stored in PostgreSQL.
- **Monitoring:** Include logs and health endpoints for basic observability.

---

## 7. Constraints & Assumptions
- A GitHub personal access token with minimal read scopes (for Actions API) is required.
- The system supports both polling and webhook-based modes for collecting pipeline data.
- Version 1.0 will integrate only with GitHub; future versions can extend to GitLab or Bitbucket.

---

## 8. Acceptance Criteria
- `docker-compose up` successfully runs backend, frontend, and Postgres services.
- Dashboard accurately displays latest build data for at least one GitHub workflow.
- Failure alerts are automatically pushed to Slack after unsuccessful builds.
- Project includes comprehensive AI usage and prompt logs as part of documentation.

