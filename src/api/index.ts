import { Hono } from 'hono';
import { cors } from 'hono/cors';

/**
 * Environment bindings for Cloudflare Workers
 */
export interface Env {
  DB: D1Database;
  ENVIRONMENT?: string;
}

// Define the app with proper typing for environment
const app = new Hono<{ Bindings: Env }>();

// Enable CORS for development
// Note: Using '*' for development/local testing only
// TODO: In production, restrict to specific allowed origins
app.use('/*', cors());

// Root API endpoint
app.get('/api', (c) => {
  return c.json({
    message: 'eshop API',
    version: '0.1.0',
    endpoints: {
      health: '/api/health',
      'db-ping': '/api/db/ping',
    },
  });
});

// Health check endpoint
app.get('/api/health', (c) => {
  return c.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    service: 'eshop-api',
  });
});

// Database connectivity check endpoint
app.get('/api/db/ping', async (c) => {
  try {
    // Execute a simple query to test database connectivity
    const result = await c.env.DB.prepare('SELECT 1 as ping').first();
    
    if (result && result.ping === 1) {
      return c.json({
        status: 'ok',
        message: 'Database connection successful',
        timestamp: new Date().toISOString(),
      });
    } else {
      return c.json(
        {
          status: 'error',
          message: 'Database query returned unexpected result',
        },
        500
      );
    }
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    return c.json(
      {
        status: 'error',
        message: 'Database connection failed',
        error: errorMessage,
      },
      500
    );
  }
});

// 404 handler for API routes
app.notFound((c) => {
  return c.json(
    {
      error: {
        code: 'NOT_FOUND',
        message: 'The requested resource was not found',
      },
    },
    404
  );
});

// Error handler
app.onError((err, c) => {
  console.error('API Error:', err);
  return c.json(
    {
      error: {
        code: 'INTERNAL_ERROR',
        message: 'An internal error occurred',
        details: err.message,
      },
    },
    500
  );
});

export default app;
