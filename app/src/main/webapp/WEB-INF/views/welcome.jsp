<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Enterprise Cloud Operations Portal</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: #0b1120;
            color: #f1f5f9;
            padding-top: 70px;
            margin: 0;
            min-height: 100vh;
        }

        /* Top Navigation Bar */
        .navbar-custom {
            background: rgba(15, 23, 42, 0.95);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid #1e293b;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            margin-bottom: 0;
            border-radius: 0;
        }
        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #38bdf8 !important;
            font-weight: 800;
            font-size: 1.15rem;
            letter-spacing: -0.02em;
        }
        .navbar-brand img {
            border-radius: 8px;
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.35);
        }
        .navbar-nav > li > a {
            color: #94a3b8 !important;
            font-weight: 600;
            font-size: 0.9rem;
            transition: color 0.2s;
        }
        .navbar-nav > li > a:hover {
            color: #38bdf8 !important;
        }
        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.4);
            color: #34d399;
            padding: 4px 12px;
            border-radius: 999px;
            font-size: 0.75rem;
            font-weight: 700;
            margin-top: 14px;
        }
        .pulse-dot {
            width: 8px;
            height: 8px;
            background: #10b981;
            border-radius: 50%;
            animation: pulse 2s infinite;
        }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.4; } }

        /* Content Layout */
        .portal-container {
            max-width: 1400px;
            margin: 24px auto;
            padding: 0 20px;
        }

        /* Glassmorphism Cards */
        .card-custom {
            background: #0f172a;
            border: 1px solid #1e293b;
            border-radius: 14px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.5);
        }

        /* Profile Sidebar */
        .avatar-wrapper {
            position: relative;
            display: inline-block;
            margin-bottom: 16px;
        }
        .avatar-img {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            border: 3px solid #38bdf8;
            box-shadow: 0 0 20px rgba(56, 189, 248, 0.3);
            object-fit: cover;
        }
        .profile-name {
            font-size: 1.35rem;
            font-weight: 800;
            color: #f8fafc;
            margin: 0 0 4px;
        }
        .profile-title {
            color: #38bdf8;
            font-weight: 600;
            font-size: 0.88rem;
            margin-bottom: 12px;
        }
        .profile-meta-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #1e293b;
            font-size: 0.85rem;
        }
        .profile-meta-label { color: #64748b; font-weight: 500; }
        .profile-meta-val { color: #e2e8f0; font-weight: 600; font-family: monospace; }

        /* Metric Grid */
        .metric-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        @media (max-width: 992px) {
            .metric-grid { grid-template-columns: repeat(2, 1fr); }
        }
        .metric-card {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 12px;
            padding: 18px;
            transition: transform 0.2s, border-color 0.2s;
        }
        .metric-card:hover {
            transform: translateY(-2px);
            border-color: #38bdf8;
        }
        .metric-label {
            font-size: 0.75rem;
            color: #94a3b8;
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 0.05em;
            margin-bottom: 6px;
        }
        .metric-val {
            font-size: 1.4rem;
            font-weight: 800;
            color: #f8fafc;
        }
        .metric-sub {
            font-size: 0.78rem;
            color: #10b981;
            font-weight: 600;
            margin-top: 4px;
        }

        /* Action Buttons */
        .action-bar {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 24px;
        }
        .btn-modern-primary {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: #ffffff !important;
            font-weight: 700;
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            transition: opacity 0.2s;
            text-decoration: none !important;
        }
        .btn-modern-primary:hover { opacity: 0.9; }

        .btn-modern-secondary {
            background: #1e293b;
            color: #cbd5e1 !important;
            font-weight: 600;
            padding: 10px 18px;
            border-radius: 8px;
            border: 1px solid #334155;
            transition: all 0.2s;
            text-decoration: none !important;
        }
        .btn-modern-secondary:hover {
            background: #334155;
            border-color: #475569;
            color: #f8fafc !important;
        }

        /* Tech Badges */
        .tag-cloud {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin: 16px 0;
        }
        .tag-badge {
            background: rgba(56, 189, 248, 0.1);
            border: 1px solid rgba(56, 189, 248, 0.3);
            color: #38bdf8;
            font-size: 0.78rem;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 6px;
        }

        /* Architecture Log Item */
        .arch-card {
            background: #111827;
            border: 1px solid #1e293b;
            border-radius: 12px;
            padding: 20px;
            margin-top: 16px;
        }
        .arch-title {
            font-size: 1.05rem;
            font-weight: 700;
            color: #38bdf8;
            margin-bottom: 8px;
        }
        .arch-desc {
            color: #94a3b8;
            font-size: 0.9rem;
            line-height: 1.6;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-custom" role="navigation">
    <div class="container-fluid" style="max-width: 1400px;">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navCollapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar" style="background:#cbd5e1"></span>
                <span class="icon-bar" style="background:#cbd5e1"></span>
                <span class="icon-bar" style="background:#cbd5e1"></span>
            </button>
            <a class="navbar-brand" href="${contextPath}/welcome">
                <img alt="Brand" src="${contextPath}/resources/Images/user/logo.png" width="32" height="32">
                <span>Enterprise CloudOps</span>
            </a>
        </div>
        <div class="collapse navbar-collapse" id="navCollapse">
            <ul class="nav navbar-nav">
                <li><span class="status-pill"><span class="pulse-dot"></span> LIVE ON AWS EKS</span></li>
                <li><a href="${contextPath}/users"><i class="fa fa-users"></i> User Directory</a></li>
                <li><a href="${contextPath}/user/rabbit"><i class="fa fa-exchange"></i> RabbitMQ Queue</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="display:flex; align-items:center; gap:8px;">
                        <img src="${contextPath}/resources/Images/user/user.png" width="28" height="28" style="border-radius:50%;">
                        <span>Ankit Gawade</span>
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu" style="background:#0f172a; border:1px solid #1e293b; padding:12px; min-width:220px;">
                        <li style="color:#f8fafc; font-weight:700;">Ankit Gawade</li>
                        <li style="color:#64748b; font-size:0.8rem; margin-bottom:8px;">Lead DevOps Engineer</li>
                        <li class="divider" style="background:#1e293b;"></li>
                        <li>
                            <form id="logoutForm" method="POST" action="${contextPath}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-danger btn-block btn-xs" style="margin-top:8px;">
                                    <i class="fa fa-power-off"></i> Sign Out
                                </button>
                            </form>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Portal Body -->
<div class="portal-container">
    <div class="row">
        <!-- Left Column: Architect Profile & Credentials -->
        <div class="col-lg-4 col-md-4 col-sm-12">
            <div class="card-custom text-center">
                <div class="avatar-wrapper">
                    <img class="avatar-img" src="${contextPath}/resources/Images/user/user.png" alt="Ankit Gawade">
                </div>
                <h2 class="profile-name">Ankit Gawade</h2>
                <div class="profile-title">Lead Cloud & DevOps Engineer</div>

                <div class="tag-cloud" style="justify-content: center;">
                    <span class="tag-badge">AWS EKS</span>
                    <span class="tag-badge">Kubernetes</span>
                    <span class="tag-badge">Docker</span>
                    <span class="tag-badge">Terraform</span>
                    <span class="tag-badge">CI/CD</span>
                </div>

                <div style="text-align: left; margin-top: 16px;">
                    <div class="profile-meta-row">
                        <span class="profile-meta-label">Environment</span>
                        <span class="profile-meta-val" style="color:#10b981">Production (AWS)</span>
                    </div>
                    <div class="profile-meta-row">
                        <span class="profile-meta-label">Region</span>
                        <span class="profile-meta-val">us-east-1</span>
                    </div>
                    <div class="profile-meta-row">
                        <span class="profile-meta-label">Cluster</span>
                        <span class="profile-meta-val">enterprise-eks-cluster</span>
                    </div>
                    <div class="profile-meta-row">
                        <span class="profile-meta-label">Email</span>
                        <span class="profile-meta-val">ankit.devops@enterprise.cloud</span>
                    </div>
                    <div class="profile-meta-row">
                        <span class="profile-meta-label">Location</span>
                        <span class="profile-meta-val">Mumbai, India</span>
                    </div>
                </div>

                <div style="margin-top: 20px; text-align: left;">
                    <div style="color:#64748b; font-size:0.78rem; text-transform:uppercase; font-weight:700; margin-bottom:6px;">Executive Bio</div>
                    <p style="color:#cbd5e1; font-size:0.85rem; line-height:1.5;">
                        Specializing in automated cloud infrastructure, container orchestration with Kubernetes on AWS, immutable multi-stage builds, and end-to-end zero-downtime CI/CD workflows.
                    </p>
                </div>
            </div>
        </div>

        <!-- Right Column: Operations Hub & Multi-Tier Monitoring -->
        <div class="col-lg-8 col-md-8 col-sm-12">
            <!-- System Metric Cards -->
            <div class="metric-grid">
                <div class="metric-card">
                    <div class="metric-label">Tomcat Webapp</div>
                    <div class="metric-val">2 Replicas</div>
                    <div class="metric-sub"><i class="fa fa-check-circle"></i> High Availability</div>
                    <div style="font-size: 0.76rem; color: #94a3b8; margin-top: 8px; line-height: 1.4;">Load-balanced by Nginx reverse proxy. InitContainers enforce DB &amp; Cache readiness.</div>
                </div>
                <div class="metric-card">
                    <div class="metric-label">MySQL 8.0</div>
                    <div class="metric-val">Connected</div>
                    <div class="metric-sub"><i class="fa fa-database"></i> Port 3306 Ready</div>
                    <div style="font-size: 0.76rem; color: #94a3b8; margin-top: 8px; line-height: 1.4;">Relational store for user auth &amp; directory. Credentials injected via K8s Secrets.</div>
                </div>
                <div class="metric-card">
                    <div class="metric-label">Memcached 1.6</div>
                    <div class="metric-val">Active</div>
                    <div class="metric-sub"><i class="fa fa-bolt"></i> Port 11211 Cached</div>
                    <div style="font-size: 0.76rem; color: #94a3b8; margin-top: 8px; line-height: 1.4;">In-memory cache-aside store serving repeated queries in sub-ms from RAM.</div>
                </div>
                <div class="metric-card">
                    <div class="metric-label">RabbitMQ 3.13</div>
                    <div class="metric-val">Ready</div>
                    <div class="metric-sub"><i class="fa fa-envelope"></i> Port 5672 AMQP</div>
                    <div style="font-size: 0.76rem; color: #94a3b8; margin-top: 8px; line-height: 1.4;">Decoupled AMQP message broker offloading asynchronous background tasks.</div>
                </div>
            </div>

            <!-- Platform Operations Hub -->
            <div class="card-custom">
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:18px;">
                    <div>
                        <h3 style="margin:0 0 4px; font-weight:800; font-size:1.3rem; color:#f8fafc;">Enterprise Operations & Services</h3>
                        <p style="margin:0; color:#64748b; font-size:0.85rem;">Active services orchestrated across multiple availability zones on Amazon EKS.</p>
                    </div>
                </div>

                <div class="action-bar">
                    <a href="${contextPath}/users" class="btn-modern-primary">
                        <i class="fa fa-users"></i> Query Users Database
                    </a>
                    <a href="${contextPath}/user/rabbit" class="btn-modern-secondary">
                        <i class="fa fa-exchange"></i> Test RabbitMQ Messages
                    </a>
                </div>

                <!-- Production Architecture Highlights -->
                <div class="arch-card">
                    <div class="arch-title"><i class="fa fa-shield"></i> Multi-Tier Architecture & DevSecOps Compliance</div>
                    <div class="arch-desc">
                        This application is deployed following enterprise-grade high availability and security best practices:
                        <ul style="margin-top:8px; padding-left:20px; color:#cbd5e1;">
                            <li><strong>Reverse Proxy Tier:</strong> Hardened Nginx container terminating external requests with security headers (<code>X-Content-Type-Options: nosniff</code>, <code>X-Frame-Options: SAMEORIGIN</code>).</li>
                            <li><strong>Application Tier:</strong> Apache Tomcat 10 running Spring 6 MVC on Amazon Corretto OpenJDK with rolling updates.</li>
                            <li><strong>Dependency Synchronization:</strong> Lightweight initContainers verifying MySQL and Memcached connectivity via TCP handshake before container initialization.</li>
                            <li><strong>Decoupled Secrets:</strong> Zero hardcoded credentials; all database and queue secrets are dynamically injected from Kubernetes Secret resources.</li>
                        </ul>
                    </div>
                </div>

                <div class="arch-card" style="margin-top:16px;">
                    <div class="arch-title"><i class="fa fa-clock-o"></i> Automated CI/CD Pipeline Verification</div>
                    <div class="arch-desc">
                        Deployed via <strong>GitHub Actions</strong>: automated linting &amp; testing &rarr; multi-stage Docker build &rarr; Trivy vulnerability scanning &rarr; push to Amazon ECR &rarr; rolling deployment to Amazon EKS cluster with health verification.
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
