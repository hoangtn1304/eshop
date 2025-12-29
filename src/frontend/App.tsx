import { useState, useEffect } from 'react';
import './App.css';

interface HealthResponse {
  status: string;
  timestamp: string;
  service: string;
}

function App() {
  const [health, setHealth] = useState<HealthResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch('/api/health')
      .then((res) => res.json())
      .then((data) => {
        setHealth(data);
        setLoading(false);
      })
      .catch((err) => {
        setError(err.message);
        setLoading(false);
      });
  }, []);

  return (
    <div className="app">
      <header className="header">
        <h1>📊 eshop</h1>
        <p className="subtitle">PDF Financials Tracker</p>
      </header>

      <main className="main">
        <div className="card">
          <h2>Welcome to eshop</h2>
          <p>
            A Cloudflare-based application for tracking financial reports from
            PDF documents.
          </p>

          <div className="status-section">
            <h3>API Status</h3>
            {loading && <p className="loading">Checking API health...</p>}
            {error && <p className="error">Error: {error}</p>}
            {health && (
              <div className="health-info">
                <p className="status-ok">✓ API is {health.status}</p>
                <p className="timestamp">
                  Service: {health.service}
                  <br />
                  Last checked: {new Date(health.timestamp).toLocaleString()}
                </p>
              </div>
            )}
          </div>

          <div className="features">
            <h3>Features (Coming Soon)</h3>
            <ul>
              <li>📄 Upload PDF financial reports</li>
              <li>🔍 Extract financial data automatically</li>
              <li>📈 View YoY/QoQ trends and comparisons</li>
              <li>💾 Store and version financial data</li>
              <li>📊 Dashboard with key metrics</li>
            </ul>
          </div>
        </div>
      </main>

      <footer className="footer">
        <p>Powered by Cloudflare Workers, Hono, Vite, and React</p>
      </footer>
    </div>
  );
}

export default App;
