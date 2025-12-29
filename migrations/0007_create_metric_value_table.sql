-- Migration 0007: Create metric_value table
-- Final committed metric values for company/period/metric combinations

CREATE TABLE IF NOT EXISTS metric_value (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  company_id INTEGER NOT NULL,
  period_id INTEGER NOT NULL,
  metric_id INTEGER NOT NULL,
  value_num REAL,
  unit_scale REAL NOT NULL DEFAULT 1 CHECK(unit_scale IN (1, 1000, 1000000, 1000000000)),
  currency TEXT,
  source_version_id INTEGER,
  entered_by_user_id INTEGER,
  notes TEXT,
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL DEFAULT (unixepoch()),
  FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE,
  FOREIGN KEY (period_id) REFERENCES period(id) ON DELETE CASCADE,
  FOREIGN KEY (metric_id) REFERENCES metric(id) ON DELETE CASCADE,
  FOREIGN KEY (source_version_id) REFERENCES extraction_version(id) ON DELETE SET NULL,
  FOREIGN KEY (entered_by_user_id) REFERENCES user(id) ON DELETE SET NULL,
  UNIQUE(company_id, period_id, metric_id, source_version_id)
);

-- Indexes for metric_value lookups (as specified in DB.md section 5)
CREATE INDEX IF NOT EXISTS idx_metric_value_company_period ON metric_value(company_id, period_id);
CREATE INDEX IF NOT EXISTS idx_metric_value_company_metric ON metric_value(company_id, metric_id);
