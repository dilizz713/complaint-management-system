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
import lk.ijse.gdse71.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;

@WebServlet("/app/v1/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("index.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");

        try{
            BasicDataSource dataSource = DBConnection.getDataSource();
            ComplainDAO complainDAO = new ComplainDAO(dataSource);

            int total = complainDAO.getTotalComplaints(user.getId(), user.getRole());
            int pending = complainDAO.getPendingComplaints(user.getId(),user.getRole());

            req.setAttribute("totalComplaints", total);
            req.setAttribute("pendingComplaints", pending);
            req.setAttribute("userRole", user.getRole());

            req.getRequestDispatcher("/view/dashboard.jsp").forward(req, resp);

        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("error","Failed to load dashboard");
            req.getRequestDispatcher("/view/dashboard.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        /*------------      LOGOUT       ----------*/
        String action = req.getParameter("action");
        if("logout".equalsIgnoreCase(action)) {
            HttpSession session = req.getSession(false);
            if(session != null) {
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/view/index.jsp");
            return;
        }

        int complaintId = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");
        String  remarks = req.getParameter("remarks");

        try{
            BasicDataSource dataSource = DBConnection.getDataSource();
            ComplainDAO complainDAO = new ComplainDAO(dataSource);

            boolean updated = complainDAO.updateComplainStatusAndRemarks(complaintId , status , remarks);

            if(updated){
                req.setAttribute("success","Complaint updated successfully");
            }else{
                req.setAttribute("error","Failed to update complaint");
            }

        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("error","Internal Server Error");
        }

        doGet(req, resp);
    }
}
