<%--
  Created by IntelliJ IDEA.
  User: Dilini
  Date: 6/19/2025
  Time: 4:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.gdse71.model.Complain" %>
<%@ page import="lk.ijse.gdse71.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("signin.jsp");
        return;
    }
    List<Complain> complaints = (List<Complain>) request.getAttribute("complaints");

    // Get search parameters to keep values in inputs
    String searchUserName = request.getParameter("userName") != null ? request.getParameter("userName") : "";
    String searchDepartment = request.getParameter("department") != null ? request.getParameter("department") : "";
    String searchNic = request.getParameter("nic") != null ? request.getParameter("nic") : "";
    String searchStatus = request.getParameter("status") != null ? request.getParameter("status") : "";
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Complaints</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1d2b64, #f8cdda);
            color: #f8f9fa;
            min-height: 100vh;
        }
        .container {
            margin-top: 30px;
        }
        .card {
            border-radius: 1rem;
            box-shadow: 0 0 15px rgba(0,0,0,0.15);
            overflow: hidden;
            transition: transform 0.2s ease;
        }
        .card:hover {
            transform: scale(1.01);
        }
        .card-header {
            background-color: #0d6efd;
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .badge {
            font-size: 0.85rem;
        }
        .form-select-sm, .form-control-sm {
            border-radius: 0.5rem;
        }
        .update-btn i, .delete-btn i {
            font-size: 1.3rem;
            transition: opacity 0.2s;
        }
        .update-btn {
            color: #198754;
        }
        .delete-btn {
            color: #dc3545;
        }
        .update-btn:hover i,
        .delete-btn:hover i {
            opacity: 0.75;
        }
        .form-label {
            font-weight: 500;
        }
        .alert {
            border-radius: 0.75rem;
        }
        .back-btn {
            border-radius: 2rem;
            padding: 0.5rem 1.5rem;
        }
    </style>
</head>
<body class="p-3">

<div class="container">
    <h3 class="text-center text-white mb-4">All Complaints</h3>



    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>

    <div class="row">
        <% if (complaints != null && !complaints.isEmpty()) {
            for (Complain c : complaints) { %>
        <div class="col-md-6 mb-4">
            <div class="card bg-white text-dark">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span><i class="fas fa-clipboard me-2"></i><%= c.getTitle() %></span>
                    <span class="badge bg-secondary"><%= c.getStatus() %></span>
                </div>
                <div class="card-body">
                    <p><strong>User:</strong> <%= c.getUserName() %></p>
                    <p><strong>Department:</strong> <%= c.getDepartment() %></p>
                    <p><strong>Description:</strong> <%= c.getDescription() %></p>
                    <p><strong>Created:</strong> <%= c.getCreatedAt() %></p>
                    <p><strong>Updated:</strong> <%= c.getUpdatedAt() != null ? c.getUpdatedAt() : "-" %></p>

                    <form method="post" action="<%= request.getContextPath() %>/app/v1/viewComplaints" class="mb-3">
                        <input type="hidden" name="complaintId" value="<%= c.getId() %>">
                        <input type="hidden" name="action" value="update">
                        <div class="mb-2">
                            <label class="form-label">Status</label>
                            <select name="status" class="form-select form-select-sm">
                                <option value="PENDING" <%= "PENDING".equals(c.getStatus()) ? "selected" : "" %>>PENDING</option>
                                <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(c.getStatus()) ? "selected" : "" %>>IN_PROGRESS</option>
                                <option value="RESOLVED" <%= "RESOLVED".equals(c.getStatus()) ? "selected" : "" %>>RESOLVED</option>
                            </select>
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Remarks</label>
                            <input type="text" name="remarks" value="<%= c.getRemarks() != null ? c.getRemarks() : "" %>" class="form-control form-control-sm">
                        </div>
                        <div class="text-end">
                            <button type="submit" class="update-btn" title="Update">
                                <i class="fas fa-check-circle"></i>
                            </button>
                        </div>
                    </form>

                    <form method="post" action="<%= request.getContextPath() %>/app/v1/viewComplaints"
                          onsubmit="return confirm('Are you sure to delete this complaint?');">
                        <input type="hidden" name="complaintId" value="<%= c.getId() %>">
                        <input type="hidden" name="action" value="delete">
                        <div class="text-end">
                            <button type="submit" class="delete-btn" title="Delete">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <% } } else { %>
        <div class="col-12 text-center">
            <div class="alert alert-warning">No complaints available.</div>
        </div>
        <% } %>
    </div>

    <div class="text-center mt-4">
        <a href="<%= request.getContextPath() %>/app/v1/dashboard" class="btn btn-light back-btn">
            <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
        </a>
    </div>
</div>

</body>
</html>
