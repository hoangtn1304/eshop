# Data Model (DB-first)

## 1) Core entities
- User
- Company
- Period
- Report (optional abstraction: Annual/Quarterly report metadata)
- ImportRun (1 upload attempt)
- ExtractionVersion (raw extracted output; can have many versions per ImportRun)
- Metric (canonical metric taxonomy)
- MetricValue (final committed numbers)

## 2) Relationships
- User 1—N Company
- Company 1—N Period
- Company 1—N ImportRun
- ImportRun 1—N ExtractionVersion
- ExtractionVersion 1—N MetricValue (through Commit)
- Metric 1—N MetricValue
- Period 1—N MetricValue

## 3) Suggested fields (MVP)
### user
- id, email, created_at

### company
- id, user_id, ticker, name, exchange, country, currency (default VND), fiscal_year_end_month (optional), created_at
- unique(user_id, ticker)

### period
- id, company_id, kind: "QUARTER"|"FY", year, quarter (nullable), label (e.g., "2025Q3", "FY2024"), start_date/end_date (optional)
- unique(company_id, kind, year, quarter)

### import_run
- id, company_id, user_id, source: "UPLOAD", filename, r2_key, file_hash_sha256, file_size, status, error_message
- timestamps: uploaded_at, extracted_at, committed_at, created_at
- unique(company_id, file_hash_sha256)  (idempotency anchor)

### extraction_version
- id, import_run_id, version_no (1..n), method: "TEXT_TABLE"|"OCR", parser_name, parser_version
- raw_payload_json (tables/rows), confidence_score (0..1), warnings_json, created_at
- unique(import_run_id, version_no)

### metric
- id, code (e.g., REV, GP, NPAT, CFO, CASH, DEBT_ST, DEBT_LT, EQUITY), name, statement: "IS"|"BS"|"CF"|"RATIO"
- unit_hint: "VND"|"SHARES"|"PERCENT" etc.
- unique(code)

### metric_value
- id, company_id, period_id, metric_id, value_num, unit_scale (1|1e3|1e6|1e9), currency, source_version_id, entered_by_user_id, notes
- unique(company_id, period_id, metric_id, source_version_id) (cho phép restatement/version)
- For “current official”: add is_active flag OR maintain a pointer table `period_metric_current`

## 4) Validation rules (MVP)
- unit_scale must be one of {1, 1e3, 1e6, 1e9}
- period must exist before commit
- CFO/CFI/CFF can be negative; Revenue typically non-negative (warn if negative)
- balance sheet sanity checks (optional warnings): Assets ≈ Liabilities+Equity (tolerance)

## 5) Indexing
- metric_value(company_id, period_id)
- metric_value(company_id, metric_id)
- import_run(company_id, status, created_at)
