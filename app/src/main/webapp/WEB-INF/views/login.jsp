<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="${contextPath}/resources/images/icons/favicon.ico"/>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/fonts/iconic/css/material-design-iconic-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/vendor/animate/animate.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/vendor/css-hamburgers/hamburgers.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/vendor/animsition/css/animsition.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/vendor/select2/select2.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/vendor/daterangepicker/daterangepicker.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/util.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/main.css">
    <style>
        /* Navbar Styling */
        .navbar-custom {
            background: rgba(0, 0, 0, 0); /* Transparent background */
            border: none; /* Remove border */
        }
        .navbar-custom .navbar-brand, .navbar-custom .navbar-nav > li > a {
            color: #fff; /* White text color for contrast */
        }
        .navbar-custom .navbar-nav > li > a:hover {
            color: #007bff; /* Change link color on hover */
        }
        /* Ensure navbar is positioned correctly */
        .navbar-wrapper {
            position: absolute;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
        }
        /* Page background styling */
        body {
            background-image: url('${contextPath}/resources/Images/bg-01.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
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
            background-image: none;
        }
        body.light-theme .navbar-brand {
            color: #0284c7 !important;
        }
        body.light-theme .wrap-login100 {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }
        body.light-theme .login100-form-title {
            color: #0f172a;
        }
        body.light-theme .label-input100 {
            color: #475569;
        }
        body.light-theme .input100 {
            color: #0f172a;
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
<div class="navbar-wrapper">
    <div class="container-fluid">
        <nav class="navbar navbar-custom navbar-static-top" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbarCollapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="${contextPath}/index" style="color: #38bdf8; font-weight: 800; display: flex; align-items: center; gap: 8px;">
                        <img src="${contextPath}/resources/Images/user/logo.png" width="28" height="28" style="border-radius: 6px;">
                        Enterprise CloudOps Portal
                    </a>
                </div>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <ul class="nav navbar-nav navbar-right">
                        <!-- Add any additional menu items here -->
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</div>

<div class="limiter">
    <div class="container-login100">
        <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
            <form class="login100-form validate-form" method="POST" action="${contextPath}/login">
                <span class="login100-form-title p-b-49">
                    Login
                </span>

                <!-- Display error message if any -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <c:out value="${error}"/>
                    </div>
                </c:if>

                <div class="wrap-input100 validate-input m-b-23" data-validate="Username is required">
                    <span class="label-input100">Username</span>
                    <input class="input100" type="text" name="username" placeholder="Type your username" required autofocus>
                    <span class="focus-input100" data-symbol="&#xf206;"></span>
                </div>

                <div class="wrap-input100 validate-input" data-validate="Password is required">
                    <span class="label-input100">Password</span>
                    <input class="input100" type="password" name="password" placeholder="Type your password" required>
                    <span class="focus-input100" data-symbol="&#xf190;"></span>
                </div>

                <div class="text-right p-t-8 p-b-31">
                    <a href="#">
                        Forgot password?
                    </a>
                </div>

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="container-login100-form-btn">
                    <div class="wrap-login100-form-btn">
                        <div class="login100-form-bgbtn"></div>
                        <button class="login100-form-btn">
                            Login
                        </button>
                    </div>
                </div>

                <div class="flex-col-c p-t-35">
                    <span class="txt1 p-b-9">
                        Don't have an account?
                    </span>

                    <a href="${contextPath}/registration" class="txt2">
                        Sign Up
                    </a>
                </div>

                <div style="margin-top: 28px; padding: 12px 16px; background: rgba(15, 23, 42, 0.95); border: 1px solid #1e293b; border-left: 3px solid #38bdf8; border-radius: 8px; font-size: 0.78rem; color: #94a3b8; line-height: 1.5; text-align: left;">
                    <strong style="color: #38bdf8;"><i class="fa fa-shield"></i> Ingress Security (Nginx 1.27):</strong> Traffic terminates at a hardened reverse proxy enforcing security headers (<code>X-Frame-Options: SAMEORIGIN</code>, <code>X-Content-Type-Options: nosniff</code>) before proxying upstream to Tomcat on port 8080.
                </div>
            </form>
        </div>
    </div>
</div>

<div id="dropDownSelect1"></div>

<!--===============================================================================================-->
<script src="${contextPath}/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="${contextPath}/resources/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
<script src="${contextPath}/resources/vendor/bootstrap/js/popper.js"></script>
<script src="${contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="${contextPath}/resources/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
<script src="${contextPath}/resources/vendor/daterangepicker/moment.min.js"></script>
<script src="${contextPath}/resources/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
<script src="${contextPath}/resources/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
<script src="${contextPath}/resources/js/main.js"></script>

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
