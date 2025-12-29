# Database Setup Guide

This document provides instructions for setting up and working with the D1 database for the eshop application.

## Overview

The application uses Cloudflare D1, a serverless SQL database, to store financial tracking data. The database schema is managed through migrations.

## Database Schema

The database consists of 7 main tables:

1. **user** - Users who own companies and perform imports
2. **company** - Companies tracked by users
3. **period** - Reporting periods (quarters/fiscal years)
4. **import_run** - Tracks each PDF upload attempt
5. **extraction_version** - Raw extracted output from PDFs
6. **metric** - Canonical metric taxonomy (e.g., Revenue, Net Profit)
7. **metric_value** - Final committed metric values

For detailed schema information, see `/docs/DB.md`.

## Local Development Setup

### 1. Install Dependencies

```bash
npm install
```

### 2. Apply Database Migrations

To create all necessary tables locally:

```bash
npm run db:migrate
```

This command runs all migration files in the `migrations/` directory and creates the tables in a local D1 database.

### 3. Seed the Database (Optional)

To populate the database with sample data for testing:

```bash
npm run db:seed
```

This will insert:
- 2 test users
- 3 sample companies (Vinamilk, Vietcombank, Hoa Phat Group)
- 31 canonical metrics (Revenue, COGS, Net Profit, etc.)
- 8 sample periods for testing

### 4. Start the Development Server

```bash
npm run dev
```

The API will be available at `http://localhost:8787`

### 5. Verify Database Connectivity

Test the database connection:

```bash
curl http://localhost:8787/api/db/ping
```

Expected response:
```json
{
  "status": "ok",
  "message": "Database connection successful",
  "timestamp": "2025-12-29T03:59:58.941Z"
}
```

## Production Setup

### 1. Create D1 Database

First, create the database in Cloudflare:

```bash
npx wrangler d1 create eshop-db
```

Update `wrangler.toml` with the returned `database_id`.

### 2. Apply Migrations to Production

```bash
npm run db:migrate:prod
```

## Database Commands

- `npm run db:migrate` - Apply migrations locally
- `npm run db:migrate:prod` - Apply migrations to production
- `npm run db:seed` - Load seed data locally

## Direct Database Access

To execute custom SQL queries:

**Local:**
```bash
npx wrangler d1 execute eshop-db --local --command "SELECT * FROM user;"
```

**Production:**
```bash
npx wrangler d1 execute eshop-db --remote --command "SELECT * FROM user;"
```

## Migration Files

Migrations are located in `/migrations/` and are numbered sequentially:

- `0001_create_user_table.sql`
- `0002_create_company_table.sql`
- `0003_create_period_table.sql`
- `0004_create_import_run_table.sql`
- `0005_create_extraction_version_table.sql`
- `0006_create_metric_table.sql`
- `0007_create_metric_value_table.sql`

## Troubleshooting

### Issue: Migrations not applying

Make sure you're in the project root directory and run:
```bash
npm run db:migrate
```

### Issue: Database connection fails

1. Check that migrations have been applied
2. Verify the D1 binding in `wrangler.toml`
3. Ensure the dev server is running

### Issue: Tables already exist

D1 migrations are idempotent - the `IF NOT EXISTS` clause prevents errors when re-running migrations.

## API Endpoints

### GET /api/db/ping

Tests database connectivity.

**Response:**
```json
{
  "status": "ok",
  "message": "Database connection successful",
  "timestamp": "2025-12-29T03:59:58.941Z"
}
```

### GET /api/health

Health check endpoint for the API.

**Response:**
```json
{
  "status": "ok",
  "timestamp": "2025-12-29T03:59:58.941Z"
}
```

## Next Steps

After setting up the database:

1. Explore the API endpoints (see `/docs/API.md`)
2. Review the data model (see `/docs/DB.md`)
3. Check the architecture (see `/docs/ARCH.md`)
4. Follow the roadmap (see `/docs/ROADMAP.md`)
