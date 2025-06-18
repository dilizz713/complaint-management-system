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
        response.sendRedirect("signin.jsp");
        return;
    }

    List<Complain> complaints = (List<Complain>) request.getAttribute("complaints");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Complaint Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
<h2 class="mb-4 text-center">Submit a Complaint</h2>


<% if (request.getAttribute("error") != null) { %>
<div class="alert alert-danger"><%= request.getAttribute("error") %></div>
<% } else if (request.getAttribute("success") != null) { %>
<div class="alert alert-success"><%= request.getAttribute("success") %></div>
<% } %>


<form action="<%= request.getContextPath() %>/app/v1/complaint" method="post" class="mb-5">
    <div class="mb-3">
        <label for="title" class="form-label">Complaint Title</label>
        <input type="text" class="form-control" id="title" name="title" placeholder="Enter title" required>
    </div>
    <div class="mb-3">
        <label for="description" class="form-label">Complaint Description</label>
        <textarea class="form-control" id="description" name="description" rows="4" placeholder="Describe the issue" required></textarea>
    </div>
    <div class="d-grid gap-2 d-md-block">
        <button type="submit" class="btn btn-primary">Submit Complaint</button>
        <a href="<%= request.getContextPath() %>/app/v1/dashboard" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</form>

<h3 class="mb-3">Your Complaint History</h3>
<table class="table table-bordered table-hover">
    <thead class="table-dark">
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
                        c.getStatus().equals("RESOLVED") ? "success" :
                        c.getStatus().equals("IN_PROGRESS") ? "warning" :
                        "secondary" %>">
                        <%= c.getStatus() %>
                    </span>
        </td>
        <td><%= c.getCreatedAt() %></td>
        <td><%= c.getUpdatedAt() %></td>
    </tr>
    <%   }
    } else { %>
    <tr><td colspan="5" class="text-center">No complaints found.</td></tr>
    <% } %>
    </tbody>
</table>
</body>
</html>

