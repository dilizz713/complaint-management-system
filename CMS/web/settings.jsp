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
        response.sendRedirect("signin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Settings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f0f2f5;
            padding: 40px;
        }
        .settings-container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
        }
        .form-section {
            margin-bottom: 40px;
        }
    </style>
</head>
<body>

<div class="settings-container">
    <h2 class="mb-4 text-center">User Settings</h2>

    <% String success = (String) request.getAttribute("success");
        if (success != null) { %>
    <div class="alert alert-success"><%= success %></div>
    <% } %>

    <% String error = (String) request.getAttribute("error");
        if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
    <% } %>


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

    <div class="text-end">
        <a href="<%= request.getContextPath() %>/app/v1/dashboard" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</div>

</body>
</html>

