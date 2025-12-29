/**
 * Environment bindings for Cloudflare Workers
 */
export interface Env {
  DB: D1Database;
  ENVIRONMENT?: string;
}

/**
 * Main worker entry point
 */
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    
    // CORS headers for API requests
    // Note: Using '*' for development/local testing only
    // TODO: In production, restrict to specific allowed origins
    const corsHeaders = {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, X-APP-TOKEN',
    };

    // Handle CORS preflight
    if (request.method === 'OPTIONS') {
      return new Response(null, {
        status: 204,
        headers: corsHeaders,
      });
    }

    // Route: /api/db/ping - Database connectivity check
    if (url.pathname === '/api/db/ping' && request.method === 'GET') {
      try {
        // Execute a simple query to test database connectivity
        const result = await env.DB.prepare('SELECT 1 as ping').first();
        
        if (result && result.ping === 1) {
          return new Response(
            JSON.stringify({
              status: 'ok',
              message: 'Database connection successful',
              timestamp: new Date().toISOString(),
            }),
            {
              status: 200,
              headers: {
                'Content-Type': 'application/json',
                ...corsHeaders,
              },
            }
          );
        } else {
          return new Response(
            JSON.stringify({
              status: 'error',
              message: 'Database query returned unexpected result',
            }),
            {
              status: 500,
              headers: {
                'Content-Type': 'application/json',
                ...corsHeaders,
              },
            }
          );
        }
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : 'Unknown error';
        return new Response(
          JSON.stringify({
            status: 'error',
            message: 'Database connection failed',
            error: errorMessage,
          }),
          {
            status: 500,
            headers: {
              'Content-Type': 'application/json',
              ...corsHeaders,
            },
          }
        );
      }
    }

    // Route: /api/health - Health check endpoint
    if (url.pathname === '/api/health' && request.method === 'GET') {
      return new Response(
        JSON.stringify({
          status: 'ok',
          timestamp: new Date().toISOString(),
        }),
        {
          status: 200,
          headers: {
            'Content-Type': 'application/json',
            ...corsHeaders,
          },
        }
      );
    }

    // Default 404 response
    return new Response(
      JSON.stringify({
        error: {
          code: 'NOT_FOUND',
          message: 'Endpoint not found',
        },
      }),
      {
        status: 404,
        headers: {
          'Content-Type': 'application/json',
          ...corsHeaders,
        },
      }
    );
  },
};
