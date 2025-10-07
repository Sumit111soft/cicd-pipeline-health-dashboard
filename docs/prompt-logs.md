# prompt-logs.md

## Record 001 — Project kickoff (user brief)

**Date:** 2025-08-26

**User request (paraphrased):**
Act as a senior DevOps engineer and help me build a *CI/CD Pipeline Health Dashboard* that monitors pipeline runs from systems like **GitHub Actions** and **Jenkins**.

### Goals / High-level requirements

* **Metric collection & visualization:** Capture and show pipeline KPIs such as success vs failure rate, mean build duration, and the status of the latest runs.
* **Alerting:** Send immediate notifications (Slack and Email) when builds fail and support simple escalation rules.
* **User interface:** A lightweight web dashboard that displays aggregated metrics and recent build logs with drill-down details.
* **Deployment:** The full solution must be containerized (Docker) so it can be deployed locally or in production easily.
* **AI usage:** Document how GPT-based assistance (GPT‑4) was used during design and implementation.

### Expected deliverables (files / artifacts)

* `prompt-logs.md` — record of prompts used and iterations.
* `requirement-analysis.md` — detailed functional + non-functional requirements.
* `tech-design.md` — architecture, dataflow, APIs, and deployment notes.
* `src/` — complete source code (backend + frontend + alerting integration).
* Docker assets (`Dockerfile`, `docker-compose.yml`) — for local and reference deployments.
* `README.md` — setup, run instructions, and an AI usage summary.

### Process requested by user

Deliver the project in iterative steps. For every step produce the required artefacts: design docs, code snippets, test instructions and configuration files. Keep `prompt-logs.md` up-to-date with every prompt issued to the AI and the relevant responses.

---

## Assistant plan (how I will help — condensed)

1. Create the project skeleton and repository layout.
2. Draft the requirement-analysis and tech-design documents.
3. Implement the backend to ingest and normalize webhook/polled events, store them in the database, compute metrics and emit realtime updates.
4. Implement the frontend dashboard (React) to show metrics and logs, and connect to the backend over REST + WebSockets.
5. Add alerting (Slack + SMTP) and a configurable escalation rule.
6. Containerize the whole stack with Docker and provide a docker-compose for quick local runs.
7. Produce the README, AI usage summary, and keep `prompt-logs.md` updated with every prompt used.

---

## Example prompt variants (different phrasings that should produce the same results)

Use these reworded prompts with the AI so results remain functionally equivalent but phrased differently:

* **Prompt A (design):** "You are a senior DevOps engineer — propose an architecture for a CI/CD monitoring dashboard that ingests events from GitHub Actions and Jenkins, persists them, computes success/failure rates and average build times, and streams realtime updates to a web UI. Also suggest alerting strategies (Slack/email) and a Docker-based deployment plan."

* **Prompt B (webhook handler):** "Generate an Express.js webhook handler for GitHub Actions that verifies signatures, normalizes workflow and job payloads into a standard schema (provider, repo, job_name, run_id, status, duration_ms, started_at, finished_at, logs_url, raw_payload) and stores the record in a Postgres database using Knex."

* **Prompt C (DB schema):** "Draft Knex migrations to create a Postgres `builds` table to store normalized CI events with appropriate indexes for fast metric queries (by repo and created_at)."

* **Prompt D (frontend):** "Create React components (Vite) for a small dashboard: a success/failure percentage widget for the past 24 hours, an average build time widget, a recent builds table and a build-detail modal that shows logs. Use Socket.IO to receive live events."

* **Prompt E (alerts):** "Write Node.js functions that send Slack messages via incoming webhook and emails via nodemailer for failed builds. Also, outline a simple escalation rule: send an escalation email if there are >= N failures for the same repo within T minutes."

* **Prompt F (deployment):** "Provide a docker-compose setup that runs backend, frontend, Postgres and Redis for local development. Include environment variable examples and instructions to run migrations at startup."

---

## Notes

* Keep a running record of exact prompt text and the AI responses in this file as the project progresses.
* When re-using prompts, prefer one of the above variants to maintain originality while preserving intent and expected outputs.

**Assistant action:** I will use the variant prompts above (and iterate as needed) while producing the deliverables listed. I will append each prompt + response pair to this document as development continues.

