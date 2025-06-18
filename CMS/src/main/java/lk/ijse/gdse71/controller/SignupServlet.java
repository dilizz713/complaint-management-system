package lk.ijse.gdse71.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse71.dao.UserDAO;
import lk.ijse.gdse71.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/app/v1/signup")
public class SignupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String nic = req.getParameter("nic");
        String department = req.getParameter("department");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        if(name == null || nic == null || department == null || email == null || password == null || role == null){
            req.setAttribute("error", "Please fill all the required fields");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
            return;
        }

        try{
            ServletContext context = getServletContext();
            UserDAO userDAO = new UserDAO((BasicDataSource) context.getAttribute("dataSource"));


            User user = new User(name , nic , department , email,password , role);
            boolean success = userDAO.addUser(user);

            if(success){
                req.setAttribute("success", "Registered successfully!");
                resp.sendRedirect("signin.jsp");
            }else{
                req.setAttribute("error", "Signup failed");
                req.getRequestDispatcher("signup.jsp").forward(req, resp);
            }
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("error", "Internal server error");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
        }
    }
}
