-- Migration 0003: Create period table
-- Reporting periods (quarters/fiscal years) for companies

CREATE TABLE IF NOT EXISTS period (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  company_id INTEGER NOT NULL,
  kind TEXT NOT NULL CHECK(kind IN ('QUARTER', 'FY')),
  year INTEGER NOT NULL,
  quarter INTEGER CHECK(quarter IS NULL OR (quarter >= 1 AND quarter <= 4)),
  label TEXT NOT NULL,
  start_date TEXT,
  end_date TEXT,
  created_at INTEGER NOT NULL DEFAULT (unixepoch()),
  FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE,
  UNIQUE(company_id, kind, year, quarter)
);

-- Indexes for period lookups
CREATE INDEX IF NOT EXISTS idx_period_company_id ON period(company_id);
CREATE INDEX IF NOT EXISTS idx_period_company_year ON period(company_id, year);
