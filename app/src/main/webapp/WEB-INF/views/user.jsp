<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Record Telemetry | CloudOps</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: 'Inter', -apple-system, sans-serif;
            background: #0b1120;
            color: #f1f5f9;
            padding-top: 80px;
            margin: 0;
            min-height: 100vh;
        }
        .navbar-custom {
            background: rgba(15, 23, 42, 0.95);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid #1e293b;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
        }
        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #38bdf8 !important;
            font-weight: 800;
            font-size: 1.15rem;
        }
        .navbar-nav > li > a {
            color: #94a3b8 !important;
            font-weight: 600;
            font-size: 0.9rem;
        }
        .portal-box {
            max-width: 1000px;
            margin: 30px auto;
            background: #0f172a;
            border: 1px solid #1e293b;
            border-radius: 14px;
            padding: 30px;
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
        .live-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 999px;
            font-size: 0.75rem;
            font-weight: 800;
            letter-spacing: 0.04em;
        }
        .data-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin-top: 20px;
        }
        @media (max-width: 768px) {
            .data-grid { grid-template-columns: 1fr; }
        }
        .data-card {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 10px;
            padding: 16px 20px;
        }
        .data-label {
            font-size: 0.75rem;
            color: #94a3b8;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 4px;
        }
        .data-value {
            font-size: 1.05rem;
            font-weight: 600;
            color: #f8fafc;
        }
        .btn-back-dir {
            background: #334155;
            color: #f8fafc !important;
            padding: 8px 18px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.85rem;
            text-decoration: none !important;
            margin-right: 8px;
        }
        .btn-back-dash {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: #ffffff !important;
            padding: 8px 18px;
            border-radius: 6px;
            font-weight: 700;
            font-size: 0.85rem;
            text-decoration: none !important;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-custom" role="navigation">
        <div class="container-fluid" style="max-width: 1300px;">
            <div class="navbar-header">
                <a class="navbar-brand" href="${contextPath}/welcome">
                    <img src="${contextPath}/resources/Images/user/logo.png" width="30" height="30" style="border-radius:6px;">
                    Enterprise CloudOps
                </a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="${contextPath}/users"><i class="fa fa-users"></i> All Users</a></li>
                    <li><a href="${contextPath}/welcome"><i class="fa fa-dashboard"></i> Back to Dashboard</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="portal-box">
            <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:12px;">
                <div>
                    <h2 style="margin:0 0 6px; font-weight:800; color:#f8fafc;">
                        <i class="fa fa-id-badge" style="color:#38bdf8"></i> User Record: <c:out value="${user.username}"/>
                    </h2>
                    <p style="margin:0; color:#94a3b8; font-size:0.9rem;">Internal database record telemetry ID #${user.id}</p>
                </div>
                <div>
                    <a href="${contextPath}/users" class="btn-back-dir"><i class="fa fa-arrow-left"></i> Directory</a>
                    <a href="${contextPath}/welcome" class="btn-back-dash"><i class="fa fa-dashboard"></i> Dashboard</a>
                </div>
            </div>

            <!-- In-App Architecture Explanation Card -->
            <div class="arch-callout">
                <div class="arch-callout-header">
                    <i class="fa fa-info-circle"></i>
                    <span>HOW THIS WORKS &bull; CACHE-ASIDE PATTERN (MEMCACHED + MYSQL)</span>
                    <span style="margin-left: auto;">
                        <c:choose>
                            <c:when test="${Result != null && Result.contains('Cache')}">
                                <span class="live-pill" style="background: rgba(16, 185, 129, 0.2); border: 1px solid #10b981; color: #34d399;">
                                    <i class="fa fa-bolt"></i> SERVED FROM RAM (MEMCACHED :11211)
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="live-pill" style="background: rgba(56, 189, 248, 0.2); border: 1px solid #38bdf8; color: #38bdf8;">
                                    <i class="fa fa-database"></i> FETCHED FROM MYSQL & CACHED
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="arch-callout-body">
                    The application implements a <strong>cache-aside pattern using Memcached on port 11211</strong>. On the first lookup, data is fetched from <strong>MySQL on port 3306</strong> and stored in Memcached RAM. Subsequent queries are served directly from RAM in sub-milliseconds without touching the database.
                </div>
            </div>

            <div class="data-grid">
                <div class="data-card">
                    <div class="data-label">Database ID</div>
                    <div class="data-value" style="color:#38bdf8; font-family:monospace;">#<c:out value="${user.id}"/></div>
                </div>
                <div class="data-card">
                    <div class="data-label">Username</div>
                    <div class="data-value"><c:out value="${user.username}"/></div>
                </div>
                <div class="data-card">
                    <div class="data-label">Email Address</div>
                    <div class="data-value" style="color:#34d399;"><c:out value="${user.userEmail}"/></div>
                </div>
                <div class="data-card">
                    <div class="data-label">Contact Phone</div>
                    <div class="data-value"><c:out value="${user.phoneNumber != null ? user.phoneNumber : 'N/A'}"/></div>
                </div>
                <div class="data-card">
                    <div class="data-label">Primary Role / Occupation</div>
                    <div class="data-value"><c:out value="${user.primaryOccupation != null ? user.primaryOccupation : 'Enterprise Operator'}"/></div>
                </div>
                <div class="data-card">
                    <div class="data-label">Technical Skills</div>
                    <div class="data-value"><c:out value="${user.skills != null ? user.skills : 'Kubernetes, AWS, Docker'}"/></div>
                </div>
                <div class="data-card">
                    <div class="data-label">Location / Address</div>
                    <div class="data-value"><c:out value="${user.permanentAddress != null ? user.permanentAddress : 'Mumbai, India'}"/></div>
                </div>
                <div class="data-card">
                    <div class="data-label">Account Status</div>
                    <div class="data-value" style="color:#10b981;"><i class="fa fa-check-circle"></i> Active & Verified</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
