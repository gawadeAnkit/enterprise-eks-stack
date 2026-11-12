process.env.NODE_ENV = process.env.NODE_ENV || 'production';
const http = require('node:http');
const os = require('node:os');
const fs = require('node:fs');
const path = require('node:path');

const PORT = process.env.PORT || 3000;
const APP_VERSION = process.env.APP_VERSION || 'dev';

// ── Helpers ──────────────────────────────────────────────────────────
function respond(res, statusCode, contentType, body) {
  res.writeHead(statusCode, {
    'Content-Type': contentType,
    'X-Content-Type-Options': 'nosniff',
    'X-Frame-Options': 'DENY',
    'Cache-Control': 'no-store',
  });
  res.end(body);
}

// Probe a service endpoint and return { name, url, status, latencyMs }
async function probeService(name, url, timeoutMs = 3000) {
  const start = Date.now();
  try {
    const ctrl = new AbortController();
    const timer = setTimeout(() => ctrl.abort(), timeoutMs);
    const r = await fetch(url, { signal: ctrl.signal });
    clearTimeout(timer);
    return { name, url, status: r.ok ? 'healthy' : 'degraded', latencyMs: Date.now() - start };
  } catch {
    return { name, url, status: 'unreachable', latencyMs: Date.now() - start };
  }
}

async function collectMetrics() {
  const services = [
    { name: 'Dashboard (self)', url: `http://localhost:${PORT}/health` },
    { name: 'Webapp Proxy', url: `http://enterprise-proxy/health` },
    { name: 'Tomcat App', url: `http://enterprise-webapp:8080/` },
  ];
  const probes = await Promise.allSettled(services.map(s => probeService(s.name, s.url)));
  return probes.map(p => p.status === 'fulfilled' ? p.value : { name: 'unknown', status: 'error', latencyMs: 0 });
}

// ── Dashboard HTML ────────────────────────────────────────────────────
function buildDashboardHtml(metrics) {
  const statusColor = s => s === 'healthy' ? '#10b981' : s === 'degraded' ? '#f59e0b' : '#ef4444';
  const statusIcon  = s => s === 'healthy' ? '✓' : s === 'degraded' ? '⚠' : '✗';
  const cards = metrics.map(m => `
    <div class="service-card">
      <div class="service-icon" style="color:${statusColor(m.status)}">${statusIcon(m.status)}</div>
      <div class="service-info">
        <div class="service-name">${m.name}</div>
        <div class="service-meta">${m.latencyMs}ms · ${m.status}</div>
      </div>
      <div class="service-badge" style="background:${statusColor(m.status)}20;color:${statusColor(m.status)}">${m.status.toUpperCase()}</div>
    </div>`).join('');

  const allHealthy = metrics.every(m => m.status === 'healthy');
  const overallStatus = allHealthy ? 'ALL SYSTEMS OPERATIONAL' : 'DEGRADED SERVICES';
  const overallColor  = allHealthy ? '#10b981' : '#f59e0b';

  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <meta http-equiv="refresh" content="10"/>
  <title>DevOps Platform Dashboard</title>
  <style>
    *{box-sizing:border-box;margin:0;padding:0}
    body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;background:#060b18;color:#e2e8f0;min-height:100vh}
    .topbar{background:#0d1526;border-bottom:1px solid #1e3a5f;padding:14px 32px;display:flex;align-items:center;justify-content:space-between}
    .logo{display:flex;align-items:center;gap:12px}
    .logo-icon{width:36px;height:36px;background:linear-gradient(135deg,#3b82f6,#8b5cf6);border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:18px}
    .logo-text{font-size:1.1rem;font-weight:700;color:#f8fafc}
    .logo-sub{font-size:.75rem;color:#64748b;margin-top:1px}
    .topbar-right{display:flex;align-items:center;gap:16px}
    .version-tag{background:#1e3a5f;border:1px solid #2563eb;border-radius:6px;padding:4px 10px;font-size:.8rem;color:#93c5fd;font-family:monospace}
    .live-dot{width:8px;height:8px;background:#10b981;border-radius:50%;animation:pulse 2s infinite}
    @keyframes pulse{0%,100%{opacity:1}50%{opacity:.4}}
    .container{max-width:1200px;margin:0 auto;padding:32px}
    .hero{background:linear-gradient(135deg,#0d1526 0%,#111827 100%);border:1px solid #1e3a5f;border-radius:16px;padding:32px;margin-bottom:28px;position:relative;overflow:hidden}
    .hero::before{content:'';position:absolute;top:-40%;right:-10%;width:300px;height:300px;background:radial-gradient(circle,#3b82f620,transparent 60%);pointer-events:none}
    .overall-badge{display:inline-flex;align-items:center;gap:8px;background:${overallColor}18;border:1px solid ${overallColor}60;color:${overallColor};padding:6px 14px;border-radius:999px;font-size:.82rem;font-weight:700;margin-bottom:16px}
    .hero-title{font-size:2rem;font-weight:800;color:#f8fafc;margin-bottom:8px}
    .hero-sub{color:#64748b;font-size:.95rem}
    .grid-3{display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-bottom:28px}
    @media(max-width:768px){.grid-3{grid-template-columns:1fr}}
    .stat-card{background:#0d1526;border:1px solid #1e3a5f;border-radius:12px;padding:20px}
    .stat-label{font-size:.78rem;color:#64748b;text-transform:uppercase;letter-spacing:.05em;margin-bottom:8px}
    .stat-value{font-size:1.6rem;font-weight:800;color:#f8fafc;font-family:monospace}
    .stat-sub{font-size:.8rem;color:#475569;margin-top:4px}
    .section-title{font-size:1rem;font-weight:700;color:#94a3b8;text-transform:uppercase;letter-spacing:.08em;margin-bottom:14px}
    .services-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:12px;margin-bottom:28px}
    .service-card{background:#0d1526;border:1px solid #1e3a5f;border-radius:12px;padding:16px;display:flex;align-items:center;gap:14px;transition:border-color .2s}
    .service-card:hover{border-color:#3b82f6}
    .service-icon{font-size:1.4rem;font-weight:900;width:32px;text-align:center}
    .service-name{font-weight:600;color:#f1f5f9;font-size:.92rem}
    .service-meta{font-size:.78rem;color:#64748b;margin-top:2px;font-family:monospace}
    .service-badge{margin-left:auto;padding:3px 10px;border-radius:6px;font-size:.72rem;font-weight:700;white-space:nowrap}
    .arch-card{background:#0d1526;border:1px solid #1e3a5f;border-radius:12px;padding:24px;margin-bottom:28px}
    .arch-flow{display:flex;align-items:center;justify-content:center;flex-wrap:wrap;gap:12px;margin-top:16px}
    .arch-box{background:#111827;border:1px solid #1e3a5f;border-radius:10px;padding:12px 18px;text-align:center;min-width:110px}
    .arch-box-label{font-size:.7rem;color:#64748b;text-transform:uppercase;letter-spacing:.06em}
    .arch-box-tech{font-size:.88rem;font-weight:700;color:#93c5fd;margin-top:3px}
    .arch-arrow{color:#3b82f6;font-size:1.3rem}
    .footer{text-align:center;padding:24px 0;color:#334155;font-size:.8rem;border-top:1px solid #0f1f35;margin-top:12px}
    .refresh-note{font-size:.74rem;color:#334155;text-align:right;margin-top:8px}
  </style>
</head>
<body>
  <div class="topbar">
    <div class="logo">
      <div class="logo-icon">⚡</div>
      <div>
        <div class="logo-text">DevOps Platform</div>
        <div class="logo-sub">Enterprise EKS Deployment</div>
      </div>
    </div>
    <div class="topbar-right">
      <div class="version-tag">v${APP_VERSION}</div>
      <div class="live-dot" title="Auto-refreshes every 10s"></div>
    </div>
  </div>

  <div class="container">
    <div class="hero">
      <div class="overall-badge">
        <div style="width:7px;height:7px;border-radius:50%;background:${overallColor}"></div>
        ${overallStatus}
      </div>
      <div class="hero-title">Enterprise Application Stack</div>
      <div class="hero-sub">Multi-tier Java application orchestrated on Amazon EKS — deployed via GitHub Actions CI/CD</div>
    </div>

    <div class="grid-3">
      <div class="stat-card">
        <div class="stat-label">Pod Hostname</div>
        <div class="stat-value" style="font-size:1rem">${os.hostname()}</div>
        <div class="stat-sub">Running on Amazon EKS</div>
      </div>
      <div class="stat-card">
        <div class="stat-label">System Uptime</div>
        <div class="stat-value">${Math.floor(process.uptime() / 60)}m</div>
        <div class="stat-sub">${new Date().toUTCString()}</div>
      </div>
      <div class="stat-card">
        <div class="stat-label">Monitored Services</div>
        <div class="stat-value">${metrics.length}</div>
        <div class="stat-sub">${metrics.filter(m=>m.status==='healthy').length} healthy · ${metrics.filter(m=>m.status!=='healthy').length} issues</div>
      </div>
    </div>

    <div class="section-title">Service Health</div>
    <div class="services-grid">${cards}</div>

    <div class="arch-card">
      <div class="section-title">Deployment Architecture</div>
      <div class="arch-flow">
        <div class="arch-box"><div class="arch-box-label">Users</div><div class="arch-box-tech">Internet</div></div>
        <div class="arch-arrow">→</div>
        <div class="arch-box"><div class="arch-box-label">CDN / LB</div><div class="arch-box-tech">AWS ELB</div></div>
        <div class="arch-arrow">→</div>
        <div class="arch-box"><div class="arch-box-label">Proxy</div><div class="arch-box-tech">Nginx 1.27</div></div>
        <div class="arch-arrow">→</div>
        <div class="arch-box"><div class="arch-box-label">Application</div><div class="arch-box-tech">Tomcat 10</div></div>
        <div class="arch-arrow">→</div>
        <div class="arch-box"><div class="arch-box-label">Database</div><div class="arch-box-tech">MySQL 8.0</div></div>
      </div>
      <div class="arch-flow" style="margin-top:12px">
        <div class="arch-box"><div class="arch-box-label">Cache</div><div class="arch-box-tech">Memcached</div></div>
        <div style="color:#64748b;font-size:.9rem;padding:0 8px">+</div>
        <div class="arch-box"><div class="arch-box-label">Queue</div><div class="arch-box-tech">RabbitMQ 3.13</div></div>
        <div style="color:#64748b;font-size:.9rem;padding:0 8px">+</div>
        <div class="arch-box"><div class="arch-box-label">Orchestration</div><div class="arch-box-tech">Amazon EKS 1.31</div></div>
        <div style="color:#64748b;font-size:.9rem;padding:0 8px">+</div>
        <div class="arch-box"><div class="arch-box-label">CI/CD</div><div class="arch-box-tech">GitHub Actions</div></div>
      </div>
    </div>

    <div class="refresh-note">Auto-refreshing every 10 seconds</div>
    <div class="footer">Enterprise DevOps Platform · Built &amp; deployed by gawadeAnkit · Amazon EKS us-east-1</div>
  </div>
</body>
</html>`;
}

// ── Request Handler ───────────────────────────────────────────────────
async function requestHandler(req, res) {
  const url = new URL(req.url, `http://localhost`);

  if (url.pathname === '/health') {
    return respond(res, 200, 'application/json', JSON.stringify({ status: 'healthy', uptime: process.uptime() }));
  }

  if (url.pathname === '/ready') {
    return respond(res, 200, 'application/json', JSON.stringify({ status: 'ready' }));
  }

  if (url.pathname === '/api/metrics') {
    const metrics = await collectMetrics();
    return respond(res, 200, 'application/json', JSON.stringify({ timestamp: new Date().toISOString(), services: metrics }));
  }

  if (url.pathname === '/') {
    const metrics = await collectMetrics();
    return respond(res, 200, 'text/html; charset=utf-8', buildDashboardHtml(metrics));
  }

  return respond(res, 404, 'application/json', JSON.stringify({ error: 'Not Found' }));
}

const server = http.createServer(requestHandler);
server.listen(PORT, () => {
  console.log(JSON.stringify({ level: 'INFO', event: 'server_started', port: PORT, version: APP_VERSION, pod: os.hostname() }));
});

const shutdown = sig => {
  console.log(JSON.stringify({ level: 'INFO', event: 'graceful_shutdown', signal: sig }));
  server.close(() => process.exit(0));
  setTimeout(() => process.exit(1), 10000);
};
process.on('SIGTERM', () => shutdown('SIGTERM'));
process.on('SIGINT',  () => shutdown('SIGINT'));

