package lk.ijse.gdse71.controller;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse71.dao.ComplainDAO;
import lk.ijse.gdse71.db.DBConnection;
import lk.ijse.gdse71.model.Complain;
import lk.ijse.gdse71.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/app/v1/viewComplaints")
public class ViewAllComplaints extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if(user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/view/index.jsp");
            return;
        }

        try{
            BasicDataSource ds = DBConnection.getDataSource();
            ComplainDAO complainDAO = new ComplainDAO(ds);


            List<Complain> complaints = complainDAO.getAllComplaints();
            request.setAttribute("complaints", complaints);
            request.getRequestDispatcher("/view/viewComplaint.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load all complaints");
            request.getRequestDispatcher("/view/viewComplaint.jsp").forward(request, response);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/view/index.jsp");
            return;
        }

        String action = request.getParameter("action");
        int complaintId = Integer.parseInt(request.getParameter("complaintId"));

        try {
            BasicDataSource ds = DBConnection.getDataSource();
            ComplainDAO complainDAO = new ComplainDAO(ds);


            /*----------------------                  UPDATE COMPLAINTS             -------------------   */
            if ("update".equals(action)) {
                String status = request.getParameter("status");
                String remarks = request.getParameter("remarks");

                boolean updated = complainDAO.updateComplaint(complaintId, status, remarks);
                request.setAttribute("success", updated ? "Complaint updated." : "Update failed.");

                /*----------------------                  DELETE COMPLAINTS             -------------------   */
            } else if ("delete".equals(action)) {
                boolean deleted = complainDAO.deleteComplaint(complaintId);
                request.setAttribute("success", deleted ? "Complaint deleted." : "Delete failed.");
            }


            List<Complain> complaints = complainDAO.getAllComplaints();
            request.setAttribute("complaints", complaints);
            request.getRequestDispatcher("/view/viewComplaint.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error");
            request.getRequestDispatcher("/view/viewComplaint.jsp").forward(request, response);
        }
    }
}
