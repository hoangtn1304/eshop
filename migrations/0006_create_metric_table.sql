-- Migration 0006: Create metric table
-- Canonical metric taxonomy (e.g., Revenue, Net Profit, Cash Flow)

CREATE TABLE IF NOT EXISTS metric (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  statement TEXT NOT NULL CHECK(statement IN ('IS', 'BS', 'CF', 'RATIO')),
  unit_hint TEXT,
  created_at INTEGER NOT NULL DEFAULT (unixepoch())
);

-- Index for metric code lookups
CREATE INDEX IF NOT EXISTS idx_metric_code ON metric(code);
