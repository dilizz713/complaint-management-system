package lk.ijse.gdse71.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse71.dao.ComplainDAO;
import lk.ijse.gdse71.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;

@WebServlet("/app/v1/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("signin.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");

        System.out.println(user);

        try{
            ServletContext context = getServletContext();
            BasicDataSource dataSource = (BasicDataSource) context.getAttribute("dataSource");

            ComplainDAO complainDAO = new ComplainDAO(dataSource);

            int total = complainDAO.getTotalComplaints(user.getId(), user.getRole());
            int pending = complainDAO.getPendingComplaints(user.getId(),user.getRole());

            req.setAttribute("totalComplaints", total);
            req.setAttribute("pendingComplaints", pending);

            req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);

        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("error","Failed to load dashboard");
            req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
        }
    }
}
