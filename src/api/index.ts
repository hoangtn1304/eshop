import { Hono } from 'hono';
import { cors } from 'hono/cors';

// Define the app with proper typing
const app = new Hono();

// Enable CORS for development
app.use('/*', cors());

// Health check endpoint
app.get('/api/health', (c) => {
  return c.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    service: 'eshop-api',
  });
});

// Root API endpoint
app.get('/api', (c) => {
  return c.json({
    message: 'eshop API',
    version: '0.1.0',
    endpoints: {
      health: '/api/health',
    },
  });
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
