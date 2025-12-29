# API Contract (REST, design-only)

Base: /api

## Auth
- MVP A: Admin token header `X-APP-TOKEN: ...`
- Later: /auth/login, /auth/callback, /auth/me

## Companies
- GET /companies
- POST /companies { ticker, name, exchange?, fiscal_year_end_month? }
- GET /companies/:id

## Periods
- GET /companies/:id/periods
- POST /companies/:id/periods { kind, year, quarter?, label? }

## Upload / Import Runs
- POST /companies/:id/import-runs/init
  - req: { filename, size_bytes }
  - resp: { import_run_id, r2_put_url, r2_key }
- POST /import-runs/:id/complete
  - marks UPLOADED; compute/store hash if provided
- GET /companies/:id/import-runs
- GET /import-runs/:id

## Extraction
- POST /import-runs/:id/extract
  - starts extraction; resp { status }
- GET /import-runs/:id/extractions
- GET /extractions/:id
  - returns raw_payload_json for review UI

## Commit (map raw rows → canonical metrics)
- POST /import-runs/:id/commit
  - req: { period: {kind, year, quarter?}, unit_scale, mappings: [{metric_code, value, notes?}] }
  - resp: { committed_metric_values_count }

## Dashboard
- GET /companies/:id/metrics?periods=...&metrics=...
- GET /companies/:id/timeline?metric=REV&from=2023Q1&to=2025Q3

## Errors model
- { error: { code, message, details? } }
- Status: 400 validation, 401 auth, 404 not found, 409 conflict (duplicate hash), 500 server
