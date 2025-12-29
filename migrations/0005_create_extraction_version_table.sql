-- Migration 0005: Create extraction_version table
-- Raw extracted output from PDFs (can have multiple versions per import)

CREATE TABLE IF NOT EXISTS extraction_version (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  import_run_id INTEGER NOT NULL,
  version_no INTEGER NOT NULL,
  method TEXT NOT NULL CHECK(method IN ('TEXT_TABLE', 'OCR')),
  parser_name TEXT,
  parser_version TEXT,
  raw_payload_json TEXT,
  confidence_score REAL CHECK(confidence_score IS NULL OR (confidence_score >= 0 AND confidence_score <= 1)),
  warnings_json TEXT,
  created_at INTEGER NOT NULL DEFAULT (unixepoch()),
  FOREIGN KEY (import_run_id) REFERENCES import_run(id) ON DELETE CASCADE,
  UNIQUE(import_run_id, version_no)
);

-- Indexes for extraction_version lookups
CREATE INDEX IF NOT EXISTS idx_extraction_version_import_run_id ON extraction_version(import_run_id);
