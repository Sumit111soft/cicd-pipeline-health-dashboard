# Technical Design — CI/CD Pipeline Health Dashboard

## 1. Technology Stack Overview
To ensure scalability, ease of maintenance, and fast development, the following stack has been selected:

- **Backend:** `FastAPI` (Python 3.11+) — chosen for its asynchronous support, high performance, and automatic OpenAPI documentation.
- **Frontend:** `React` with `Vite` and `Tailwind CSS` — provides a responsive UI, quick build times, and modern styling flexibility.
- **Database:** `PostgreSQL` (via Docker Compose). A fallback option using SQLite is available for lightweight testing or local setups.
- **Caching & Messaging (optional):** `Redis` can be introduced for caching API responses or implementing rate-limiting.
- **Deployment:** Fully containerized setup using Docker and managed through `docker-compose`.
- **Alerting:** Primary alert mechanism via **Slack Webhooks**; optional email notifications through SMTP integration.

---

## 2. High-Level Architecture
The system follows a **modular microservice-style** layout within a single deployment stack.  
Below is a textual description of the core components:

1. **Frontend Service (React)**  
   - Displays pipeline health metrics, charts, and recent build logs.  
   - Communicates with the backend via REST APIs.  
   - Runs on a lightweight Node.js-based container served on port 5173 (default for Vite).

2. **Backend Service (FastAPI)**  
   - Exposes REST endpoints for metrics retrieval and alerts management.  
   - Periodically fetches workflow data from GitHub Actions API.  
   - Provides health checks and metrics endpoints.  
   - Can run background schedulers (for polling GitHub data).

3. **Database Layer (PostgreSQL)**  
   - Stores pipeline metrics, execution logs, and configuration settings.  
   - Acts as a persistent layer between backend refresh cycles.

4. **Alerting Component**  
   - Listens for failed build events or detects failure patterns during scheduled syncs.  
   - Triggers Slack messages or emails when thresholds are breached.

5. **Optional Caching Layer (Redis)**  
   - Used to reduce repeated API calls and improve data freshness.  
   - Stores temporary run summaries and polling timestamps.

6. **Deployment Orchestrator (Docker Compose)**  
   - Manages all service containers (frontend, backend, database, redis).  
   - Defines environment variables for tokens, API keys, and database credentials.  
   - Enables single-command startup (`docker-compose up -d`).

---

## 3. Data Flow Summary
1. The backend polls or receives webhook data from **GitHub Actions API**.  
2. Retrieved run metadata and logs are stored in **PostgreSQL**.  
3. The **frontend** fetches this information through API endpoints and visualizes it as charts, tables, and real-time indicators.  
4. On failure detection, the **alerting module** triggers Slack or email notifications.  
5. Metrics update at defined intervals or instantly (if webhooks are enabled).

---

## 4. API Endpoints (sample set)
| Endpoint | Method | Description |
|-----------|---------|-------------|
| `/api/runs` | GET | Fetch recent pipeline executions |
| `/api/metrics` | GET | Get success/failure rates, average build time |
| `/api/logs/{run_id}` | GET | Retrieve logs for a specific pipeline run |
| `/api/alerts/test` | POST | Send test notification to Slack |
| `/health` | GET | Basic health check for monitoring |

---

## 5. Configuration & Environment
| Variable | Description |
|-----------|-------------|
| `GITHUB_TOKEN` | Token used to access GitHub Actions data |
| `DATABASE_URL` | PostgreSQL connection string |
| `SLACK_WEBHOOK_URL` | Slack webhook for notifications |
| `POLL_INTERVAL_MINUTES` | Frequency for polling GitHub API |
| `ALERT_THRESHOLD` | Define failure threshold before alerting |
| `NODE_ENV` / `BACKEND_ENV` | Application environment (dev/prod) |

---

## 6. Deployment Design
The deployment relies on Docker Compose with three essential services:

```yaml
services:
  backend:
    build: ./backend
    ports:
      - "3000:3000"
    env_file: .env
    depends_on:
      - db

  frontend:
    build: ./frontend
    ports:
      - "5173:5173"

  db:
    image: postgres:15
    environment:
      POSTGRES_USER: ciuser
      POSTGRES_PASSWORD: cipass
      POSTGRES_DB: cicd_dashboard

