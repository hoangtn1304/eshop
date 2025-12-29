-- Migration 0001: Create user table
-- Users who own companies and perform imports

CREATE TABLE IF NOT EXISTS user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT NOT NULL UNIQUE,
  created_at INTEGER NOT NULL DEFAULT (unixepoch())
);

-- Index for email lookups
CREATE INDEX IF NOT EXISTS idx_user_email ON user(email);
