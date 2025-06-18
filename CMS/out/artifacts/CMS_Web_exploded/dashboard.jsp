<%@ page import="lk.ijse.gdse71.model.User" %><%--
  Created by IntelliJ IDEA.
  User: Dilini
  Date: 6/17/2025
  Time: 3:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lk.ijse.gdse71.model.User" %>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("user");
    System.out.println(user);
    if (user == null) {
        response.sendRedirect("signin.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            background: #f4f4f4;
            font-family: 'Segoe UI', sans-serif;
        }
        .sidebar {
            background: #343a40;
            color: white;
            min-height: 100vh;
        }
        .sidebar h4 {
            padding: 20px;
            border-bottom: 1px solid #555;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background: #495057;
        }
        .content {
            padding: 20px;
        }
        .navbar-icons {
            display: flex;
            gap: 15px;
        }
        .navbar-icons i {
            font-size: 18px;
            color: #555;
            cursor: pointer;
        }
        .navbar-icons i:hover {
            color: #000;
        }
        .icon-profile {
            color: #ffc107;
        }

        .icon-add {
            color: #28a745;
        }

        .icon-view {
            color: #17a2b8;
        }

        .icon-settings {
            color: #6c757d;
        }

        .icon-logout {
            color: #dc3545;
        }
        .role{
            font-size: 15px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">

        <div class="col-md-3 sidebar">
            <h4>
                <i class="fas fa-user-circle icon-profile"></i>
                <%= user.getName() %>
                <br>
                <small class="role"><%= user.getRole() %></small>
            </h4>
            <a href="<%= request.getContextPath() %>/app/v1/complaint">
                <i class="fas fa-plus-circle icon-add"></i> Add Complaint
            </a>
            <a href=""><i class="fas fa-list icon-view"></i> View Complaints</a>
        </div>


        <div class="col-md-9">
            <div class="d-flex justify-content-between align-items-center mt-3 mb-4">
                <h2>Welcome, <%= user.getName() %>!</h2>
                <div class="navbar-icons">
                    <a href="<%= request.getContextPath() %>/settings.jsp" title="Settings">
                        <i class="fas fa-cog icon-settings"></i>
                    </a>
                    <form action="app/v1/logout" method="post" style="display:inline;">
                        <button type="submit" style="border:none; background:none;">
                            <i class="fas fa-sign-out-alt icon-logout" title="Logout"></i>
                        </button>
                    </form>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="card shadow-sm mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Total Complaints</h5>
                            <p class="card-text display-6">15</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card shadow-sm mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Pending Complaints</h5>
                            <p class="card-text display-6">5</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="alert alert-info">
                You are logged in as <strong><%= user.getEmail() %></strong> from <%= user.getDepartment() %> department.
            </div>
        </div>
    </div>
</div>


<script>

</script>
</body>
</html>
