-- Migration 0004: Create import_run table
-- Tracks each PDF upload attempt

CREATE TABLE IF NOT EXISTS import_run (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  company_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  source TEXT NOT NULL DEFAULT 'UPLOAD',
  filename TEXT NOT NULL,
  r2_key TEXT,
  file_hash_sha256 TEXT,
  file_size INTEGER,
  status TEXT NOT NULL DEFAULT 'UPLOADED' CHECK(status IN ('UPLOADED', 'EXTRACTING', 'EXTRACTED', 'REVIEWED', 'COMMITTED', 'FAILED')),
  error_message TEXT,
  uploaded_at INTEGER NOT NULL DEFAULT (unixepoch()),
  extracted_at INTEGER,
  committed_at INTEGER,
  created_at INTEGER NOT NULL DEFAULT (unixepoch()),
  FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
  UNIQUE(company_id, file_hash_sha256)
);

-- Indexes for import_run lookups
CREATE INDEX IF NOT EXISTS idx_import_run_company_id ON import_run(company_id);
CREATE INDEX IF NOT EXISTS idx_import_run_status ON import_run(company_id, status, created_at);
CREATE INDEX IF NOT EXISTS idx_import_run_user_id ON import_run(user_id);
