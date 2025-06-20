package lk.ijse.gdse71.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse71.dao.UserDAO;
import lk.ijse.gdse71.db.DBConnection;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;

@WebServlet("/app/v1/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if(email == null || newPassword == null || confirmPassword == null || email.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()){
            req.setAttribute("error", "Please enter all the fields correctly!");
            req.getRequestDispatcher("/view/forgotPassword.jsp").forward(req, resp);
            return;
        }

        if(!newPassword.equals(confirmPassword)){
            req.setAttribute("error", "Passwords do not match!");
            req.getRequestDispatcher("/view/forgotPassword.jsp").forward(req, resp);
            return;
        }

        try{
            BasicDataSource ds = DBConnection.getDataSource();
            UserDAO userDAO = new UserDAO(ds);

            boolean success = userDAO.updatePasswordByEmail(email, newPassword);

            if (success) {
                req.setAttribute("success", "Password updated successfully.");
                req.getRequestDispatcher("/view/index.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "No user found with that email.");
                req.getRequestDispatcher("/view/forgotPassword.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Internal server error.");
            req.getRequestDispatcher("/view/forgotPassword.jsp").forward(req, resp);
        }

    }
}
