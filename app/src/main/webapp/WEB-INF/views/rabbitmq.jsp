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
            margin-top: 20px;
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

            <div style="background:#111827; border:1px solid #1e293b; border-radius:10px; padding:20px; margin-top:20px;">
                <h4 style="margin:0 0 10px; color:#38bdf8; font-weight:700;"><i class="fa fa-info-circle"></i> Broker Orchestration Details</h4>
                <p style="color:#cbd5e1; font-size:0.88rem; line-height:1.6; margin:0;">
                    Message broker service <code>enterprise-rmq</code> (RabbitMQ 3.13) provides decoupled asynchronous message processing for worker queues across worker nodes in <code>us-east-1</code>.
                </p>
            </div>

            <div style="text-align:center; margin-top:24px;">
                <a href="${contextPath}/welcome" class="btn-portal"><i class="fa fa-arrow-left"></i> Return to CloudOps Portal</a>
            </div>
        </div>
    </div>
</body>
</html>
