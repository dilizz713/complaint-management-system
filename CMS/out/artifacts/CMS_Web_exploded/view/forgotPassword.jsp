<%--
  Created by IntelliJ IDEA.
  User: Dilini
  Date: 6/20/2025
  Time: 2:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1d2b64, #f8cdda);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .forgot-password-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 500px;
        }

        .form-label {
            font-weight: 600;
        }

        .btn-primary {
            background-color: #ff4e50;
            border-color: #ff4e50;
        }

        .btn-primary:hover {
            background-color: #e64547;
            border-color: #e64547;
        }
    </style>
</head>
<body>
<div class="forgot-password-card">
    <h3 class="mb-3 text-center">Reset Password</h3>
    <p class="text-muted text-center">Enter your email and set a new password</p>

    <%-- Error message --%>
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="alert alert-danger"><%= error %></div>
    <%
        }
    %>

    <%-- Success message --%>
    <%
        String success = (String) request.getAttribute("success");
        if (success != null) {
    %>
    <div class="alert alert-success"><%= success %></div>
    <%
        }
    %>

    <form action="<%= request.getContextPath() %>/app/v1/forgotPassword" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>
            <input type="email" class="form-control" id="email" name="email"
                   required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                   title="Enter a valid email address">
        </div>

        <div class="mb-3">
            <label for="newPassword" class="form-label">New Password</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword"
                   required minlength="6" pattern=".{6,}" title="Password must be at least 6 characters">
        </div>

        <div class="mb-3">
            <label for="confirmPassword" class="form-label">Confirm Password</label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                   required minlength="6" pattern=".{6,}" title="Passwords must match">
        </div>

        <div class="form-check mb-3">
            <input type="checkbox" class="form-check-input" id="showPassword" onclick="togglePassword()">
            <label class="form-check-label" for="showPassword">Show Passwords</label>
        </div>

        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary">Reset Password</button>
            <a href="index.jsp" class="btn btn-outline-secondary">Back to Sign In</a>
        </div>
    </form>
</div>

<script>
    function togglePassword() {
        const newPwd = document.getElementById("newPassword");
        const confirmPwd = document.getElementById("confirmPassword");
        newPwd.type = newPwd.type === "password" ? "text" : "password";
        confirmPwd.type = confirmPwd.type === "password" ? "text" : "password";
    }
</script>
</body>
</html>
