# Architecture (Cloudflare-native)

## 1) Components
- Cloudflare Pages: frontend (SPA)
- Cloudflare Workers: API (REST)
- Cloudflare D1: relational data (companies, periods, metrics, import runs, versions)
- Cloudflare R2: PDF object storage
- (Optional) Cloudflare Queues: async extraction jobs (M2+)
- (Optional) KV: cache (company list, recent dashboard) — không bắt buộc MVP

## 2) High-level flow (MVP text-based extraction)
1) Upload PDF → API returns signed upload URL (or direct upload) → store in R2
2) Create ImportRun in D1 with status=UPLOADED, file_hash, r2_key
3) Trigger extraction (sync for MVP; async later)
4) Save ExtractionVersion (raw extracted rows + confidence + parser metadata)
5) UI Review: user maps rows → canonical metrics → validate units → Commit
6) Commit creates MetricValues for (company_id, period_id, metric_id, version_id)

## 3) Security model
- MVP option A (fast): single-user mode with one admin token (header) stored in env (acceptable for personal use).
- MVP option B: email-based login; session cookie/JWT.
- Authorization: per user ownership of companies/import runs.

## 4) Observability
- Every ImportRun has status transitions + timestamps:
  - UPLOADED → EXTRACTING → EXTRACTED → REVIEWED → COMMITTED (or FAILED)
- Log correlation id = import_run_id.
- Store parse errors + validation errors in D1 for debugging.

## 5) Cost drivers
- R2 storage (PDFs)
- OCR (if later) is the big cost/time driver
- Worker CPU time for parsing large PDFs
