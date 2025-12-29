# Roadmap & PR Plan (Copilot-friendly)

## Milestones
### M0 (Day 1–3): Bootstrap infra
- Pages app skeleton + Workers API + D1 connected + R2 bucket configured
- DoD: deploy succeeds; /api/health returns ok; D1 migration runs

### M1 (Week 1): Upload + ImportRun audit trail
- Upload PDF to R2
- Create/list ImportRuns per company
- DoD: user can upload 1 PDF, see it in list, open details page

### M2 (Week 2): Extraction v0 (text-based) + Review screen
- Parser extracts tables/rows from selectable-text PDFs
- Store ExtractionVersion.raw_payload_json
- Review UI shows extracted rows; user can edit values/mapping before commit
- DoD: 1 PDF → extracted rows visible; commit writes MetricValues

### M3 (Week 3): Canonical metrics + YoY/QoQ dashboard
- Canonical taxonomy v1 (30–60 metrics)
- Dashboard table: current period, QoQ%, YoY%
- DoD: timeline shows at least 8 periods; deltas correct

### M4 (Week 4+): Insights v0 (rules)
- Rule engine flags warnings on dashboard
- DoD: 10 rules running; each rule links to “why flagged”

## PR slicing (đề xuất 12 PR nhỏ)
1) Repo structure + tooling + /docs placeholders
2) D1 schema migrations (User/Company/Period/ImportRun)
3) Companies CRUD API + minimal UI list/create
4) R2 upload init/complete endpoints + ImportRun list UI
5) ImportRun detail page (status, file link, history)
6) ExtractionVersion table + API to create/read (no parser yet)
7) Text-table parser v0 (limited scope) + save extraction
8) Review UI: show extracted rows + manual edit
9) Commit endpoint: map to MetricValues + validations
10) Dashboard API: fetch metrics timeline
11) Dashboard UI: YoY/QoQ table
12) Basic rule flags (v0 insights)

## Definition of Done (mọi PR)
- CI pipeline passes (lint, typecheck, test, build)
- Feature works end-to-end for stated scope
- Types strict; no unused
- Minimal tests (API unit or integration light)
- Docs updated (ROADMAP/ARCH/DB if schema changes)
