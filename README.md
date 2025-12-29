# eshop - PDF Financials Tracker

A Cloudflare-based application for tracking financial reports from PDF documents.

## Tech Stack

- **Frontend**: React + Vite
- **Backend**: Cloudflare Workers + Hono
- **Language**: TypeScript
- **Development**: Wrangler CLI
- **Code Quality**: ESLint + Prettier

See [docs/STACK.md](docs/STACK.md) for detailed technology decisions.

## Prerequisites

- Node.js 18+ 
- npm 9+

## Getting Started

### Installation

```bash
npm install
```

### Development

```bash
# Start the Workers API dev server
npm run dev

# The API will be available at http://localhost:8787
```

For frontend development with hot reload:

```bash
# In a separate terminal, start Vite dev server
cd src/frontend
npx vite

# Frontend will be available at http://localhost:5173
# API calls will be proxied to http://localhost:8787
```

### Building

```bash
npm run build
```

This builds both:
- Frontend: Vite builds React app to `dist/`
- API: TypeScript compiles Workers code

### Code Quality

```bash
# Run linter
npm run lint

# Fix linting issues
npm run lint:fix

# Check TypeScript types
npm run typecheck

# Check code formatting
npm run format:check

# Auto-format code
npm run format
```

## Project Structure

```
eshop/
├── src/
│   ├── api/              # Cloudflare Workers API (Hono)
│   │   └── index.ts      # Main API entry point
│   └── frontend/         # React application
│       ├── App.tsx       # Main React component
│       ├── main.tsx      # React entry point
│       └── index.html    # HTML template
├── dist/                 # Build output (frontend)
├── docs/                 # Documentation
│   ├── STACK.md         # Technology stack decisions
│   ├── PRD.md           # Product requirements
│   ├── ARCH.md          # Architecture overview
│   └── API.md           # API design
├── wrangler.toml        # Cloudflare Workers configuration
├── vite.config.ts       # Vite configuration
├── tsconfig.json        # TypeScript config (frontend)
├── tsconfig.api.json    # TypeScript config (API)
└── package.json         # Dependencies and scripts
```

## API Endpoints

### Health Check

```bash
GET /api/health

Response:
{
  "status": "ok",
  "timestamp": "2025-12-29T04:00:00.000Z",
  "service": "eshop-api"
}
```

### API Info

```bash
GET /api

Response:
{
  "message": "eshop API",
  "version": "0.1.0",
  "endpoints": {
    "health": "/api/health"
  }
}
```

## Deployment

### API (Cloudflare Workers)

```bash
# Deploy to Cloudflare Workers
npx wrangler deploy
```

### Frontend (Cloudflare Pages)

The frontend (`dist/` directory) can be deployed to Cloudflare Pages:

1. Connect your repository to Cloudflare Pages
2. Set build command: `npm run build:frontend`
3. Set build output directory: `dist`
4. Deploy

## Environment Configuration

Environment bindings for D1, R2, and other Cloudflare services are configured in `wrangler.toml`. 

Uncomment and configure the placeholders as needed:

```toml
# Database
[[d1_databases]]
binding = "DB"
database_name = "eshop-db"
database_id = "your-database-id"

# Object Storage
[[r2_buckets]]
binding = "BUCKET"
bucket_name = "eshop-pdfs"

# Environment Variables
[vars]
ENVIRONMENT = "production"
```

## Development Workflow

1. **Start API dev server**: `npm run dev`
2. **Make changes** to `src/api/` or `src/frontend/`
3. **Run linter**: `npm run lint`
4. **Check types**: `npm run typecheck`
5. **Build**: `npm run build`
6. **Test endpoints**: `curl http://localhost:8787/api/health`

## Testing

```bash
npm test
```

_(Test infrastructure to be implemented)_

## Documentation

- [Product Requirements](docs/PRD.md)
- [Architecture](docs/ARCH.md)
- [API Design](docs/API.md)
- [Technology Stack](docs/STACK.md)
- [Roadmap](docs/ROADMAP.md)

## License

UNLICENSED
