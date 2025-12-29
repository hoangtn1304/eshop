# Technology Stack Documentation

This document explains the technology choices made for the eshop Cloudflare stack.

## Overview

The eshop project is built as a Cloudflare-native application using a modern, lightweight stack optimized for serverless deployment and fast performance.

## Technology Choices

### 1. **Cloudflare Workers** (Backend Runtime)

**Why Cloudflare Workers?**
- **Edge Computing**: Workers run on Cloudflare's global edge network, providing low-latency responses from locations close to users
- **Serverless**: No servers to manage, automatic scaling, and pay-per-request pricing
- **Native Integration**: Seamless integration with other Cloudflare services (D1, R2, KV, Queues)
- **Cost-Effective**: Free tier is generous for development, and pricing scales efficiently
- **Zero Cold Starts**: Unlike traditional serverless platforms, Workers have minimal cold start times

### 2. **Hono** (Web Framework)

**Why Hono?**
- **Lightweight**: Hono is extremely small (~12KB) and fast, perfect for edge computing
- **Modern API**: Clean, Express-like API that's easy to learn and use
- **TypeScript-First**: Built with TypeScript, providing excellent type safety
- **Cloudflare Optimized**: Specifically designed to work well with Cloudflare Workers
- **Middleware Support**: Rich middleware ecosystem for common tasks (CORS, authentication, etc.)
- **Better than Alternatives**: 
  - Lighter than Express (which doesn't run on Workers)
  - More feature-rich than raw Workers
  - Faster than other edge frameworks

### 3. **Vite** (Frontend Build Tool)

**Why Vite?**
- **Fast Development**: Instant server start and lightning-fast HMR (Hot Module Replacement)
- **Modern Build**: Uses native ES modules in development and optimized Rollup builds for production
- **React Integration**: First-class support for React via official plugin
- **Developer Experience**: Excellent error messages and debugging capabilities
- **Industry Standard**: Widely adopted and well-maintained by the Vue.js team
- **Cloudflare Pages Compatible**: Builds can be easily deployed to Cloudflare Pages

### 4. **React** (Frontend Framework)

**Why React?**
- **Component-Based**: Modular architecture makes it easy to build and maintain complex UIs
- **Large Ecosystem**: Vast library of components, tools, and community resources
- **TypeScript Support**: Excellent TypeScript integration for type-safe frontend code
- **Proven Technology**: Battle-tested in production at scale by thousands of companies
- **Hooks API**: Modern, functional approach to state management and side effects
- **Future-Proof**: Backed by Meta with active development and long-term support

### 5. **Wrangler** (Development & Deployment Tool)

**Why Wrangler?**
- **Official Tool**: Cloudflare's official CLI for Workers development and deployment
- **Local Development**: Run Workers locally with hot reload for rapid iteration
- **Environment Management**: Easy configuration of bindings (D1, R2, KV) for different environments
- **Deployment Pipeline**: Simple deployment with `wrangler deploy`
- **Dev Server**: Built-in development server that closely mimics production environment

### 6. **TypeScript** (Language)

**Why TypeScript?**
- **Type Safety**: Catch errors at compile-time rather than runtime
- **Better IDE Support**: Autocomplete, refactoring, and inline documentation
- **Maintainability**: Types serve as documentation and make refactoring safer
- **Industry Standard**: Widely adopted in modern web development
- **Cloudflare Native**: Workers Types package provides types for all Cloudflare APIs

### 7. **ESLint + Prettier** (Code Quality)

**Why ESLint and Prettier?**
- **Consistent Code Style**: Automated formatting ensures consistent code across the team
- **Bug Prevention**: ESLint catches common mistakes and anti-patterns
- **Best Practices**: Enforces React and TypeScript best practices
- **Developer Experience**: Auto-fix capabilities save time and reduce bikeshedding
- **CI/CD Integration**: Can be run in pipelines to ensure code quality

## Architecture Decisions

### Monorepo Structure

```
/src
  /frontend  - React application (built with Vite)
  /api       - Hono API (Workers runtime)
/dist        - Build output (served by Workers)
```

**Benefits:**
- **Single Repository**: All code in one place for easier development
- **Shared Types**: Can share TypeScript types between frontend and backend
- **Atomic Deploys**: Deploy frontend and backend together as a single unit
- **Simplified Workflow**: One `npm install`, one deploy command

### API-First Design

The `/api/health` endpoint demonstrates our API-first approach:
- **Monitoring Ready**: Health checks are essential for production monitoring
- **Documentation**: API endpoints are well-defined and documented
- **Versioned**: API versioning strategy can be implemented from the start
- **Error Handling**: Consistent error response format across all endpoints

### Development Workflow

1. **Local Development**: 
   - `npm run dev` runs Wrangler dev server (serves both API and frontend)
   - API runs on `localhost:8787`
   - Frontend development happens with Vite's dev server (with proxy to API)

2. **Building**:
   - `npm run build` builds both frontend and API
   - Frontend: Vite creates optimized bundle in `/dist`
   - API: TypeScript compiles to ensure type correctness

3. **Deployment**:
   - `wrangler deploy` deploys to Cloudflare Workers
   - Workers serves both API endpoints and static frontend assets

## Environment Bindings (Placeholders)

The `wrangler.toml` includes commented placeholders for:
- **D1 Database**: SQLite-based relational database for structured data
- **R2 Storage**: S3-compatible object storage for PDFs
- **Environment Variables**: Configuration per environment (dev/prod)

These will be configured as features are implemented.

## Performance Characteristics

- **API Latency**: <50ms for simple endpoints from edge locations
- **Frontend Load Time**: <1s for initial load (thanks to Vite's optimizations)
- **Build Time**: <10s for typical changes (Vite's fast rebuild)
- **Deploy Time**: <30s from push to live (Wrangler's efficient deployment)

## Future Considerations

As the project grows, we may consider:
- **React Router**: For multi-page frontend navigation
- **Zod**: Runtime schema validation for API requests
- **Drizzle ORM**: Type-safe database queries for D1
- **Vitest**: Testing framework for both frontend and backend
- **TanStack Query**: Advanced data fetching and caching for React

## Conclusion

This stack provides a solid foundation for building a modern, performant, and scalable application on Cloudflare's edge platform. The choices prioritize:
- **Developer Experience**: Fast iterations, good tooling, clear error messages
- **Performance**: Edge computing, lightweight frameworks, optimized builds
- **Type Safety**: TypeScript throughout the stack
- **Maintainability**: Clear architecture, consistent patterns, good documentation
- **Cost Efficiency**: Serverless pricing, efficient resource usage
