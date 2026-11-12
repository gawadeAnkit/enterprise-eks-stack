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
</body>
</html>
