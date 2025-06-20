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
    if (user == null) {
        response.sendRedirect("signin.jsp");
        return;
    }

    String userRole = (String) request.getAttribute("userRole");
    if (userRole == null){
        userRole = user.getRole();
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
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1d2b64, #f8cdda);
            color: #333;
        }

        .sidebar {
            background: linear-gradient(to bottom, #232526, #414345);
            color: #fff;
            min-height: 100vh;
            padding-top: 20px;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.4);
        }

        .sidebar h4 {
            text-align: center;
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .sidebar .role {
            display: block;
            text-align: center;
            font-size: 0.9rem;
            color: #bbb;
        }

        .sidebar a {
            display: block;
            color: #ddd;
            padding: 12px 20px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .sidebar a:hover {
            background-color: #575d63;
            color: #fff;
        }

        .icon-profile {
            color: #ffc107;
        }

        .icon-add {
            color: #17c964;
        }

        .icon-view {
            color: #1e90ff;
        }

        .icon-settings {
            color: black;
        }

        .icon-logout {
            color: #dc3545;
        }

        .welcome {
            color: #fff;
        }

        .card {
            border: none;
            border-radius: 20px;
            background: #ffffff;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-title {
            font-weight: 600;
        }

        .navbar-icons button,
        .navbar-icons a {
            background: none;
            border: none;
            color: #fff;
            margin-left: 10px;
            font-size: 1.25rem;
            transition: color 0.3s ease;
        }

        .navbar-icons button:hover,
        .navbar-icons a:hover {
            color: #ffd700;
        }

        .alert-info {
            border-radius: 12px;
            background-color: #e3f2fd;
            color: #0d6efd;
            border: none;
        }

        @media (max-width: 768px) {
            .sidebar {
                min-height: auto;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">

        <div class="col-md-3 sidebar">
            <h4><i class="fas fa-user-circle icon-profile"></i> <%= user.getName() %></h4>
            <span class="role"><%= user.getRole() %></span>
            <hr style="border-top: 1px solid #555;">
            <a href="<%= request.getContextPath() %>/app/v1/complaint">
                <i class="fas fa-plus-circle icon-add"></i> Add Complaint
            </a>
            <% if ("ADMIN".equalsIgnoreCase(userRole)) { %>
            <a href="<%= request.getContextPath() %>/app/v1/viewComplaints">
                <i class="fas fa-list icon-view"></i> View Complaints
            </a>
            <% } else { %>
            <a href="viewComplaint.jsp" onclick="denyAccess()" style="color: gray; cursor: not-allowed;">
                <i class="fas fa-list icon-view"></i> View Complaints
            </a>
            <% } %>
        </div>

        <div class="col-md-9 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="welcome">Welcome, <%= user.getName() %>!</h2>
                <div class="navbar-icons">
                    <a href="<%= request.getContextPath() %>/view/settings.jsp" title="Settings">
                        <i class="fas fa-cog icon-settings"></i>
                    </a>
                    <form id="logoutForm" action="<%= request.getContextPath() %>/app/v1/dashboard?action=logout" method="post" style="display:inline;">
                        <button type="button" title="Logout" onclick="confirmLogout()">
                            <i class="fas fa-sign-out-alt icon-logout"></i>
                        </button>
                    </form>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">Total Complaints</h5>
                            <p class="card-text display-5 text-primary fw-bold">
                                <%= request.getAttribute("totalComplaints") != null ? request.getAttribute("totalComplaints") : 0 %>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">Pending Complaints</h5>
                            <p class="card-text display-5 text-warning fw-bold">
                                <%= request.getAttribute("pendingComplaints") != null ? request.getAttribute("pendingComplaints") : 0 %>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="alert alert-info mt-4">
                You are logged in as <strong><%= user.getEmail() %></strong> from the <strong><%= user.getDepartment() %></strong> department.
            </div>
        </div>
    </div>
</div>

<script>
    function denyAccess() {
        alert("You don't have access to view all complaints.");
    }
    function confirmLogout() {
        if (confirm("Are you sure you want to log out?")) {
            document.getElementById("logoutForm").submit();
        }
    }
</script>
</body>
</html>
