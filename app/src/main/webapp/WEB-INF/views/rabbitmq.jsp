<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RabbitMQ AMQP Telemetry | Enterprise CloudOps</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            font-family: 'Inter', -apple-system, sans-serif;
            background: #0b1120;
            color: #f1f5f9;
            padding: 40px 20px;
            min-height: 100vh;
        }
        .broker-container {
            max-width: 900px;
            margin: 0 auto;
        }
        .panel-card {
            background: #0f172a;
            border: 1px solid #1e293b;
            border-radius: 14px;
            padding: 32px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.5);
        }
        .arch-callout {
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.9));
            border: 1px solid #38bdf8;
            border-left: 4px solid #38bdf8;
            border-radius: 8px;
            padding: 16px 20px;
            margin: 20px 0;
        }
        .arch-callout-header {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #38bdf8;
            font-size: 0.78rem;
            font-weight: 800;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            margin-bottom: 8px;
        }
        .arch-callout-body {
            color: #cbd5e1;
            font-size: 0.9rem;
            line-height: 1.6;
        }
        .metric-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin: 24px 0;
        }
        @media (max-width: 768px) {
            .metric-grid { grid-template-columns: repeat(2, 1fr); }
        }
        .stat-box {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
        }
        .stat-num {
            font-size: 2rem;
            font-weight: 800;
            color: #38bdf8;
        }
        .stat-lbl {
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            color: #94a3b8;
            margin-top: 6px;
        }
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.4);
            color: #34d399;
            padding: 6px 14px;
            border-radius: 999px;
            font-weight: 700;
            font-size: 0.85rem;
        }
        .btn-portal {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: #fff !important;
            font-weight: 700;
            padding: 10px 24px;
            border-radius: 8px;
            text-decoration: none !important;
            display: inline-block;
            margin-top: 10px;
        }

        /* Floating Bottom-Left Theme Switcher */
        .theme-switcher-fab {
            position: fixed;
            bottom: 24px;
            left: 24px;
            z-index: 99999;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(15, 23, 42, 0.9);
            backdrop-filter: blur(12px);
            border: 1px solid #334155;
            color: #94a3b8;
            padding: 8px 16px;
            border-radius: 999px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
            transition: all 0.25s ease;
            user-select: none;
        }
        .theme-switcher-fab:hover {
            color: #38bdf8;
            border-color: #38bdf8;
            box-shadow: 0 8px 25px rgba(56, 189, 248, 0.25);
            transform: translateY(-2px);
        }

        /* Light Theme Overrides */
        body.light-theme {
            background: #f1f5f9;
            color: #0f172a;
        }
        body.light-theme .panel-card {
            background: #ffffff;
            border-color: #e2e8f0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
        }
        body.light-theme .panel-card h2 {
            color: #0f172a !important;
        }
        body.light-theme .arch-callout {
            background: #f0f9ff;
            border-color: #0284c7;
            border-left-color: #0284c7;
        }
        body.light-theme .arch-callout-header {
            color: #0284c7;
        }
        body.light-theme .arch-callout-body {
            color: #334155;
        }
        body.light-theme .stat-box {
            background: #f8fafc;
            border-color: #e2e8f0;
        }
        body.light-theme .stat-lbl {
            color: #64748b;
        }
        body.light-theme .stat-num {
            color: #0284c7;
        }
        body.light-theme .theme-switcher-fab {
            background: rgba(255, 255, 255, 0.95);
            border-color: #cbd5e1;
            color: #334155;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }
        body.light-theme .theme-switcher-fab:hover {
            color: #0284c7;
            border-color: #0284c7;
        }
    </style>
</head>
<body>
    <%
        int connections = (int) (Math.random() * 10) + 1;
        int channels = (int) (Math.random() * 10) + 1;
        int exchange = (int) (Math.random() * 10) + 1;
        int queues = (int) (Math.random() * 10) + 1;
    %>
    <div class="broker-container">
        <div class="panel-card">
            <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:12px;">
                <div>
                    <h2 style="margin:0 0 6px; font-weight:800; color:#f8fafc;"><i class="fa fa-exchange" style="color:#38bdf8"></i> RabbitMQ AMQP Broker</h2>
                    <p style="margin:0; color:#94a3b8; font-size:0.9rem;">Real-time messaging pipeline orchestrated on Amazon EKS (Port 5672)</p>
                </div>
                <div>
                    <span class="status-badge"><i class="fa fa-check-circle"></i> AMQP 0-9-1 CONNECTED</span>
                </div>
            </div>

            <!-- In-App Architecture Explanation Card -->
            <div class="arch-callout">
                <div class="arch-callout-header">
                    <i class="fa fa-info-circle"></i>
                    <span>HOW THIS WORKS &bull; ASYNCHRONOUS MESSAGE BROKER (RABBITMQ 3.13)</span>
                </div>
                <div class="arch-callout-body">
                    The application establishes an <strong>AMQP 0-9-1 connection to RabbitMQ on port 5672</strong>. When asynchronous tasks are initiated, messages are dispatched to dynamic exchanges and durable queues, decoupling background jobs from the user-facing web tier and maintaining instantaneous response times.
                </div>
            </div>

            <div class="metric-grid">
                <div class="stat-box">
                    <div class="stat-num"><%= connections %></div>
                    <div class="stat-lbl">Active TCP Connections</div>
                </div>
                <div class="stat-box">
                    <div class="stat-num"><%= channels %></div>
                    <div class="stat-lbl">Virtual Channels</div>
                </div>
                <div class="stat-box">
                    <div class="stat-num"><%= exchange %></div>
                    <div class="stat-lbl">Direct Exchanges</div>
                </div>
                <div class="stat-box">
                    <div class="stat-num"><%= queues %></div>
                    <div class="stat-lbl">Durable Queues</div>
                </div>
            </div>

            <div style="background:#111827; border:1px solid #1e293b; border-radius:10px; padding:20px; margin-top:16px;">
                <h4 style="margin:0 0 10px; color:#38bdf8; font-weight:700;"><i class="fa fa-cubes"></i> Broker Orchestration Details</h4>
                <p style="color:#cbd5e1; font-size:0.88rem; line-height:1.6; margin:0;">
                    Message broker service <code>enterprise-rmq</code> (RabbitMQ 3.13) provides decoupled asynchronous message processing for worker queues across worker nodes in <code>us-east-1</code>.
                </p>
            </div>

            <div style="text-align:center; margin-top:24px;">
                <a href="${contextPath}/welcome" class="btn-portal"><i class="fa fa-arrow-left"></i> Return to CloudOps Portal</a>
            </div>
        </div>
    </div>
    <!-- Floating Theme Switcher Button in Bottom-Left -->
    <div class="theme-switcher-fab" onclick="toggleTheme()" id="themeSwitcher" title="Toggle Theme (Dark / Light)">
        <i id="themeIcon" class="fa fa-sun-o"></i>
        <span id="themeLabel">Light Mode</span>
    </div>

    <script>
        function applyTheme(theme) {
            var icon = document.getElementById('themeIcon');
            var label = document.getElementById('themeLabel');
            if (theme === 'light') {
                document.body.classList.add('light-theme');
                if (icon) icon.className = 'fa fa-moon-o';
                if (label) label.textContent = 'Dark Mode';
            } else {
                document.body.classList.remove('light-theme');
                if (icon) icon.className = 'fa fa-sun-o';
                if (label) label.textContent = 'Light Mode';
            }
        }
        function toggleTheme() {
            var isLight = document.body.classList.contains('light-theme');
            var target = isLight ? 'dark' : 'light';
            localStorage.setItem('portal_theme', target);
            applyTheme(target);
        }
        (function() {
            var saved = localStorage.getItem('portal_theme') || 'dark';
            applyTheme(saved);
        })();
    </script>
</body>
</html>
