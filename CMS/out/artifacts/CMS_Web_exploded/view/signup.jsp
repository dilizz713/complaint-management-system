<%--
  Created by IntelliJ IDEA.
  User: Dilini
  Date: 6/16/2025
  Time: 2:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>

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

        .signup-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 600px;
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
<div class="signup-card">
    <h2 class="mb-3 text-center">Sign Up</h2>
    <p class="lead text-center">Create your account to get started.</p>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="alert alert-danger"><%= error %></div>
    <%
        }
    %>

    <%
        String success = (String) request.getAttribute("success");
        if(success != null){
    %>
        <div class="alert alert-success"><%= success %></div>
    <%
        }
    %>

    <form action="<%= request.getContextPath() %>/app/v1/signup" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="name" name="name" required
            pattern="[A-Za-z ]{3,50}">
        </div>

        <div class="mb-3">
            <label for="nic" class="form-label">NIC</label>
            <input type="text" class="form-control" id="nic" name="nic" required
            pattern="^([0-9]{9}[VvXx]|[0-9]{12})$" title="Please Enter Valid NIC">
        </div>

        <div class="mb-3">
            <label for="department" class="form-label">Department</label>
            <input type="text" class="form-control" id="department" name="department" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email address</label>
            <input type="email" class="form-control" id="email" name="email"
            pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="Enter valid email address" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required minlength="6"
            pattern=".{6,}" title="Password must have at least 6 characters" required>
            <div class="form-check mt-2">
                <input type="checkbox" class="form-check-input" id="showPassword" onclick="togglePassword()">
                <label class="form-check-label" for="showPassword">Show Password</label>
            </div>
        </div>

        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <select class="form-select" id="role" name="role" required>
                <option value="">Select Role</option>
                <option value="EMPLOYEE">Employee</option>
                <option value="ADMIN">Admin</option>
            </select>
        </div>

        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary">Sign Up</button>
            <a href="<%= request.getContextPath() %>/view/signin.jsp" class="btn btn-outline-secondary">Already have an account?</a>
        </div>
    </form>
</div>

<script>
    function togglePassword() {
        const pwd = document.getElementById("password");
        pwd.type = (pwd.type === "password") ? "text" : "password";
    }
</script>
</body>
</html>
