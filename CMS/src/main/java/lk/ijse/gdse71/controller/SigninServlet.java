package lk.ijse.gdse71.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse71.dao.UserDAO;
import lk.ijse.gdse71.db.DBConnection;
import lk.ijse.gdse71.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;

@WebServlet("/app/v1/signin")
public class SigninServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if(email == null || password == null || email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Please enter both email and password");
            req.getRequestDispatcher("/view/signin.jsp").forward(req, resp);
            return;
        }

        try{
            BasicDataSource ds = DBConnection.getDataSource();
            UserDAO userDAO = new UserDAO(ds);

            User user = userDAO.findByEmail(email);

            if(user == null) {
                req.setAttribute("error", "No account found with this email");
                req.getRequestDispatcher("/view/signin.jsp").forward(req, resp);
            } else if (!user.getPassword().equals(password)) {
                req.setAttribute("error", "Your Password is incorrect! Please try again");
                req.getRequestDispatcher("/view/signin.jsp").forward(req, resp);

            }else{
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                resp.sendRedirect(req.getContextPath() + "/app/v1/dashboard");
            }
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("error", "Internal Server Error");
            req.getRequestDispatcher("/view/signin.jsp").forward(req, resp);
        }

    }
}
