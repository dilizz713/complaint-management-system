package lk.ijse.gdse71.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse71.dao.ComplainDAO;
import lk.ijse.gdse71.model.Complain;
import lk.ijse.gdse71.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.util.List;

@WebServlet("/app/v1/complaint")
public class ComplaintServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if(user == null) {
            resp.sendRedirect("signin.jsp");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");

        if(title == null || title.trim().isEmpty()) {
            req.setAttribute("error", "Title is Required");
            req.getRequestDispatcher("/complaint.jsp").forward(req, resp);
            return;
        }

        if(description == null || description.trim().isEmpty()) {
            req.setAttribute("error", "Description is Required");
            req.getRequestDispatcher("/complaint.jsp").forward(req, resp);
            return;
        }

        try{
            ServletContext context = getServletContext();
            BasicDataSource ds = (BasicDataSource) context.getAttribute("dataSource");

            ComplainDAO complainDAO = new ComplainDAO(ds);
            Complain complain = new Complain();

            complain.setUserId(user.getId());
            complain.setTitle(title);
            complain.setDescription(description);
            complain.setStatus("PENDING");

            boolean success = complainDAO.addComplaint(complain);

            if(success) {
                req.setAttribute("success", "Complaint Added Successfully");
                req.getRequestDispatcher("/complaint.jsp").forward(req, resp);
            }else{
                req.setAttribute("error", "Failed to submit complaint");
                req.getRequestDispatcher("/complaint.jsp").forward(req, resp);

            }
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("error", "Internal Server Error");
            req.getRequestDispatcher("/complaint.jsp").forward(req, resp);
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if(user == null) {
            resp.sendRedirect("signin.jsp");
            return;
        }

        try{
            ServletContext context = getServletContext();
            BasicDataSource ds = (BasicDataSource) context.getAttribute("dataSource");

            ComplainDAO complainDAO = new ComplainDAO(ds);
            List<Complain> complaints = complainDAO.getComplaintsByUserId(user.getId());

            req.setAttribute("complaints", complaints);
            req.getRequestDispatcher("/complaint.jsp").forward(req, resp);
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("error", "Failed to load complaint history");
            req.getRequestDispatcher("/complaint.jsp").forward(req, resp);
        }
    }
}
