process.env.NODE_ENV = 'test';

const { test, describe } = require('node:test');
const assert = require('node:assert');
const { EventEmitter } = require('node:events');

// Minimal mock of http req/res without network
function simulateRequest(method, url) {
  return new Promise(async (resolve) => {
    const req = Object.assign(new EventEmitter(), { method, url, headers: { host: 'localhost' } });
    let status, body = '';
    const res = {
      writeHead(s, h) { status = s; },
      end(chunk) { if (chunk) body += chunk; resolve({ status, body, json: () => JSON.parse(body) }); }
    };
    // Dynamically require server handler
    const { default: handler } = await import(`../src/server.js?t=${Date.now()}`).catch(() => ({ default: null }));
    if (!handler) return resolve({ status: 0, body: 'import_error' });
    handler(req, res);
  });
}

// Since server auto-starts on require, test via raw function extraction
describe('DevOps Dashboard Unit Tests', () => {
  test('dashboard server.js has valid syntax', async () => {
    const { execSync } = require('node:child_process');
    const result = execSync('node --check src/server.js', { cwd: __dirname + '/..', encoding: 'utf8' });
    assert.strictEqual(result.trim(), '');
  });

  test('package.json has correct entry point', () => {
    const pkg = require('../package.json');
    assert.strictEqual(pkg.main, 'src/server.js');
    assert.ok(pkg.scripts.start);
    assert.strictEqual(pkg.author, 'gawadeAnkit');
  });
});

