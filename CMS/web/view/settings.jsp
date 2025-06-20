<%--
  Created by IntelliJ IDEA.
  User: Dilini
  Date: 6/18/2025
  Time: 10:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lk.ijse.gdse71.model.User" %>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Settings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1d2b64, #f8cdda);
            font-family: 'Poppins', sans-serif;
            padding: 40px 20px;
            color: #333;
        }

        .settings-container {
            max-width: 850px;
            margin: auto;
            background: #fff;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.1);
        }

        .settings-container h2 {
            font-weight: 600;
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
        }

        .form-section {
            margin-bottom: 50px;
        }

        .form-section h4 {
            margin-bottom: 20px;
            font-weight: 600;
            color: #0f2027;
        }

        .form-control {
            border-radius: 12px;
            border: 1px solid #ced4da;
        }

        .form-control:focus {
            border-color: #1e90ff;
            box-shadow: 0 0 0 0.2rem rgba(30, 144, 255, 0.25);
        }

        .btn-primary {
            background-color: #1e90ff;
            border-color: #1e90ff;
            border-radius: 10px;
            padding: 10px 25px;
            font-weight: 500;
        }

        .btn-warning {
            background-color: #f39c12;
            border: none;
            border-radius: 10px;
            padding: 10px 25px;
            font-weight: 500;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
            border-radius: 10px;
            padding: 10px 25px;
            font-weight: 500;
        }

        .btn-secondary {
            border-radius: 10px;
            padding: 10px 25px;
            font-weight: 500;
        }

        .alert {
            border-radius: 12px;
            padding: 12px 20px;
            font-size: 15px;
        }

        @media (max-width: 576px) {
            .settings-container {
                padding: 25px 15px;
            }
        }
    </style>
</head>
<body>

<div class="settings-container">
    <h2>User Settings</h2>

    <% String success = (String) request.getAttribute("success");
        if (success != null) { %>
    <div class="alert alert-success shadow-sm"><%= success %></div>
    <% } %>

    <% String error = (String) request.getAttribute("error");
        if (error != null) { %>
    <div class="alert alert-danger shadow-sm"><%= error %></div>
    <% } %>

    <!-- Update Profile -->
    <div class="form-section">
        <h4>Update Profile</h4>
        <form method="post" action="<%= request.getContextPath() %>/app/v1/user">
            <div class="mb-3">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" class="form-control" name="name" id="name" value="<%= user.getName() %>" required>
            </div>

            <div class="mb-3">
                <label for="nic" class="form-label">NIC</label>
                <input type="text" class="form-control" name="nic" id="nic" value="<%= user.getNic() %>" required>
            </div>

            <div class="mb-3">
                <label for="department" class="form-label">Department</label>
                <input type="text" class="form-control" name="department" id="department" value="<%= user.getDepartment() %>" required>
            </div>

            <button type="submit" class="btn btn-primary">Update Profile</button>
        </form>
    </div>

    <!-- Update Credentials -->
    <div class="form-section">
        <h4>Update Login Credentials</h4>
        <form method="post" action="<%= request.getContextPath() %>/app/v1/user?change=credentials">
            <div class="mb-3">
                <label for="email" class="form-label">New Email</label>
                <input type="email" class="form-control" name="email" id="email" value="<%= user.getEmail() %>">
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">New Password</label>
                <input type="password" class="form-control" name="password" id="password" placeholder="Leave blank to keep current password">
            </div>

            <button type="submit" class="btn btn-warning">Update Credentials</button>
        </form>
    </div>

    <!-- Delete Account -->
    <div class="form-section">
        <h4>Delete Account</h4>
        <form method="post" action="<%= request.getContextPath() %>/app/v1/user" onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.');">
            <input type="hidden" name="change" value="delete">
            <button type="submit" class="btn btn-danger">Delete My Account</button>
        </form>
    </div>

    <!-- Back to Dashboard -->
    <div class="text-end">
        <a href="<%= request.getContextPath() %>/app/v1/dashboard" class="btn btn-secondary">← Back to Dashboard</a>
    </div>
</div>

</body>
</html>
