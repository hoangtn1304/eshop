-- Migration 0002: Create company table
-- Companies tracked by users

CREATE TABLE IF NOT EXISTS company (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  ticker TEXT NOT NULL,
  name TEXT NOT NULL,
  exchange TEXT,
  country TEXT,
  currency TEXT NOT NULL DEFAULT 'VND',
  fiscal_year_end_month INTEGER,
  created_at INTEGER NOT NULL DEFAULT (unixepoch()),
  FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
  UNIQUE(user_id, ticker)
);

-- Indexes for company lookups
CREATE INDEX IF NOT EXISTS idx_company_user_id ON company(user_id);
CREATE INDEX IF NOT EXISTS idx_company_ticker ON company(ticker);
