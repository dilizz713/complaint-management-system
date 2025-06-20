<%--
  Created by IntelliJ IDEA.
  User: Dilini
  Date: 6/18/2025
  Time: 9:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.gdse71.model.Complain" %>
<%@ page import="lk.ijse.gdse71.model.User" %>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Complain> complaints = (List<Complain>) request.getAttribute("complaints");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Complaint Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1d2b64, #f8cdda);
            font-family: 'Poppins', sans-serif;
            padding: 40px 20px;
        }

        .form-container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 35px 30px;
            border-radius: 20px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.1);
        }

        h2, h3 {
            text-align: center;
            font-weight: 600;
            margin-bottom: 25px;
            color: #2c3e50;
        }

        .btn-primary {
            background-color: #1e90ff;
            border: none;
            border-radius: 10px;
            padding: 10px 25px;
        }

        .btn-secondary {
            border-radius: 10px;
            padding: 10px 25px;
        }

        .table-container {
            max-width: 900px;
            margin: 50px auto 0 auto;
        }

        .table {
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        .table th {
            background-color: #203a43;
            color: white;
            text-align: center;
        }

        .table td {
            vertical-align: middle;
            text-align: center;
        }

        .alert {
            border-radius: 10px;
            padding: 12px 20px;
            font-size: 15px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Submit a Complaint</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } else if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/app/v1/complaint" method="post"  class="mb-4">
        <div class="mb-3">
            <label for="title" class="form-label">Complaint Title</label>
            <input type="text" class="form-control" id="title" name="title" placeholder="Enter title" required>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Complaint Description</label>
            <textarea class="form-control" id="description" name="description" rows="4" placeholder="Describe the issue" required></textarea>
        </div>
        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <button type="submit" class="btn btn-primary">Submit Complaint</button>
            <a href="<%= request.getContextPath() %>/app/v1/dashboard" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </form>
</div>

<div class="table-container">
    <h3>Your Complaint History</h3>
    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Updated At</th>
        </tr>
        </thead>
        <tbody>
        <% if (complaints != null && !complaints.isEmpty()) {
            for (Complain c : complaints) { %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getTitle() %></td>
            <td>
                <span class="badge bg-<%=
                    "RESOLVED".equals(c.getStatus()) ? "success" :
                    "IN_PROGRESS".equals(c.getStatus()) ? "warning" : "secondary" %>">
                    <%= c.getStatus() %>
                </span>
            </td>
            <td><%= c.getCreatedAt() %></td>
            <td><%= c.getUpdatedAt() %></td>
        </tr>
        <%   }
        } else { %>
        <tr><td colspan="6" class="text-center">No complaints found.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
