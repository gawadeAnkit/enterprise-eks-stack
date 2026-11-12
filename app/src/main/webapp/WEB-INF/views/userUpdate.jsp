<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update Profile | CloudOps</title>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
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
        .portal-box {
            max-width: 750px;
            margin: 0 auto;
            background: #0f172a;
            border: 1px solid #1e293b;
            border-radius: 14px;
            padding: 32px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.5);
        }
        .form-control {
            background: #1e293b;
            border: 1px solid #334155;
            color: #f8fafc;
            border-radius: 8px;
            height: 44px;
        }
        .form-control:focus {
            border-color: #38bdf8;
            box-shadow: 0 0 0 2px rgba(56, 189, 248, 0.2);
            background: #1e293b;
            color: #fff;
        }
        .control-label {
            color: #94a3b8;
            font-weight: 600;
            font-size: 0.85rem;
        }
        .btn-save {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: #fff !important;
            font-weight: 700;
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
        }
        .btn-cancel {
            background: #334155;
            color: #cbd5e1 !important;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none !important;
            margin-right: 12px;
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
        body.light-theme .portal-box {
            background: #ffffff;
            border-color: #e2e8f0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
        }
        body.light-theme .portal-box h2 {
            color: #0f172a !important;
        }
        body.light-theme .form-control {
            background: #ffffff;
            border-color: #cbd5e1;
            color: #0f172a;
        }
        body.light-theme .control-label {
            color: #475569;
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
<div class="portal-box">
    <div style="border-bottom: 1px solid #1e293b; padding-bottom: 16px; margin-bottom: 24px;">
        <h2 style="margin: 0 0 6px; font-weight: 800; color: #f8fafc;"><i class="fa fa-user-circle" style="color: #38bdf8;"></i> Update Engineer Profile</h2>
        <p style="margin: 0; color: #94a3b8; font-size: 0.9rem;">Modify cloud engineer metadata and occupational attributes</p>
    </div>

    <form:form method="POST" modelAttribute="user" class="form-horizontal">
        <fieldset>
            <div class="form-group">
                <spring:bind path="username">
                    <form:label class="col-md-3 control-label" path="username">Username</form:label>
                    <div class="col-md-9">
                        <form:input type="text" path="username" class="form-control" placeholder="Username" autofocus="true"/>
                    </div>
                </spring:bind>
            </div>

            <div class="form-group">
                <spring:bind path="userEmail">
                    <form:label class="col-md-3 control-label" path="userEmail">Email</form:label>
                    <div class="col-md-9">
                        <form:input type="email" path="userEmail" class="form-control" placeholder="Email Address"/>
                    </div>
                </spring:bind>
            </div>

            <div class="form-group">
                <spring:bind path="primaryOccupation">
                    <form:label class="col-md-3 control-label" path="primaryOccupation">Role</form:label>
                    <div class="col-md-9">
                        <form:input type="text" path="primaryOccupation" class="form-control" placeholder="e.g. Lead DevOps Engineer"/>
                    </div>
                </spring:bind>
            </div>

            <div class="form-group">
                <spring:bind path="skills">
                    <form:label class="col-md-3 control-label" path="skills">Skills</form:label>
                    <div class="col-md-9">
                        <form:input type="text" path="skills" class="form-control" placeholder="e.g. Kubernetes, AWS, Terraform, CI/CD"/>
                    </div>
                </spring:bind>
            </div>

            <div class="form-group">
                <spring:bind path="permanentAddress">
                    <form:label class="col-md-3 control-label" path="permanentAddress">Location</form:label>
                    <div class="col-md-9">
                        <form:input type="text" path="permanentAddress" class="form-control" placeholder="e.g. Mumbai, India"/>
                    </div>
                </spring:bind>
            </div>

            <div class="form-group" style="margin-top: 32px; padding-top: 16px; border-top: 1px solid #1e293b;">
                <div class="col-md-12 text-right">
                    <a href="${contextPath}/welcome" class="btn-cancel">Cancel</a>
                    <button type="submit" class="btn btn-save"><i class="fa fa-save"></i> Save Changes</button>
                </div>
            </div>
        </fieldset>
    </form:form>
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
