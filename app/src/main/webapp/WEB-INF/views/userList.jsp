<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Enterprise Directory | CloudOps</title>
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
            max-width: 1100px;
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
        .table-custom {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 16px;
            border: 1px solid #1e293b;
            border-radius: 8px;
            overflow: hidden;
        }
        .table-custom th {
            background: #1e293b;
            color: #94a3b8;
            padding: 14px 18px;
            font-weight: 700;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 1px solid #334155;
        }
        .table-custom td {
            padding: 14px 18px;
            color: #cbd5e1;
            border-bottom: 1px solid #1e293b;
            font-size: 0.9rem;
        }
        .table-custom tr:last-child td {
            border-bottom: none;
        }
        .table-custom tr:hover td {
            background: rgba(30, 41, 59, 0.5);
        }
        .btn-inspect {
            background: #1e293b;
            border: 1px solid #38bdf8;
            color: #38bdf8 !important;
            padding: 6px 14px;
            border-radius: 6px;
            font-weight: 700;
            font-size: 0.8rem;
            text-decoration: none !important;
            transition: all 0.2s;
            display: inline-block;
        }
        .btn-inspect:hover {
            background: #38bdf8;
            color: #0b1120 !important;
        }
        .btn-back {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: #ffffff !important;
            padding: 9px 20px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.88rem;
            text-decoration: none !important;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }
        .btn-back:hover {
            opacity: 0.95;
            color: #ffffff !important;
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
        body.light-theme .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            border-bottom: 1px solid #cbd5e1;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        body.light-theme .navbar-brand {
            color: #0284c7 !important;
        }
        body.light-theme .navbar-nav > li > a {
            color: #475569 !important;
        }
        body.light-theme .navbar-nav > li > a:hover {
            color: #0284c7 !important;
        }
        body.light-theme .portal-box {
            background: #ffffff;
            border-color: #e2e8f0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
        }
        body.light-theme .portal-box h2 {
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
        body.light-theme .table-custom {
            border-color: #e2e8f0;
            background: #ffffff;
        }
        body.light-theme .table-custom th {
            background: #f8fafc;
            color: #475569;
            border-bottom-color: #cbd5e1;
        }
        body.light-theme .table-custom td {
            color: #334155;
            border-bottom-color: #e2e8f0;
        }
        body.light-theme .table-custom td:nth-child(2) {
            color: #0f172a !important;
        }
        body.light-theme .table-custom tr:hover td {
            background: #f1f5f9;
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
                    <li><a href="${contextPath}/welcome"><i class="fa fa-dashboard"></i> Back to Dashboard</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="portal-box">
            <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:12px;">
                <div>
                    <h2 style="margin:0 0 6px; font-weight:800; color:#f8fafc;"><i class="fa fa-users" style="color:#38bdf8"></i> Enterprise User Directory</h2>
                    <p style="margin:0; color:#94a3b8; font-size:0.9rem;">Authenticated records retrieved from Amazon RDS / MySQL Cluster</p>
                </div>
                <div>
                    <a href="${contextPath}/welcome" class="btn-back"><i class="fa fa-arrow-left"></i> Back to Dashboard</a>
                </div>
            </div>

            <!-- In-App Architecture Explanation Card -->
            <div class="arch-callout">
                <div class="arch-callout-header">
                    <i class="fa fa-database"></i>
                    <span>HOW THIS WORKS &bull; RELATIONAL DATABASE TIER (MYSQL 8.0) & CACHE ENTRY</span>
                </div>
                <div class="arch-callout-body">
                    This directory queries the <strong>MySQL 8.0 cluster (`enterprise-db` on port 3306)</strong> using Spring Data JPA. Click <strong>"Inspect Record"</strong> on any user below to observe the <strong>Memcached (port 11211) cache-aside pattern</strong> serving data directly from RAM.
                </div>
            </div>

            <table class="table-custom">
                <thead>
                    <tr>
                        <th style="width: 120px;">Record ID</th>
                        <th>User Identifier</th>
                        <th style="width: 180px; text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="user">
                    <tr>
                        <td style="font-family: monospace; color:#38bdf8; font-weight:700;">#${user.id}</td>
                        <td style="font-weight:600; color:#f8fafc;">
                            <i class="fa fa-user-circle" style="color:#64748b; margin-right:8px;"></i>
                            <c:out value="${user.username}"/>
                        </td>
                        <td style="text-align: center;">
                            <a href="users/${user.id}" class="btn-inspect">
                                <i class="fa fa-search"></i> Inspect Record
                            </a>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
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
