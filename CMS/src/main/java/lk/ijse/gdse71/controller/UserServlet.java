package lk.ijse.gdse71.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse71.dao.UserDAO;
import lk.ijse.gdse71.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;

@WebServlet("/app/v1/user")
public class UserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("signin.jsp");
            return;
        }

        ServletContext context = getServletContext();
        BasicDataSource ds = (BasicDataSource) context.getAttribute("dataSource");
        UserDAO dao = new UserDAO(ds);

        String change = req.getParameter("change");

        try{
            if("credentials".equals(change)){
                String newEmail = req.getParameter("email");
                String newPassword = req.getParameter("password");

                if(newEmail == null || newEmail.isEmpty() && (newPassword == null || newPassword.isEmpty())){
                    req.setAttribute("error", "Please provide  email or password");
                    req.getRequestDispatcher("/settings.jsp").forward(req, resp);
                    return;

                }

                boolean success = dao.updateCredentials(user.getId(), newEmail , newPassword);

                if(success){
                    if(newEmail != null && !newEmail.isEmpty()){
                        user.setEmail(newEmail);
                    }
                    if(newPassword != null && !newPassword.isEmpty()){
                        user.setPassword(newPassword);
                    }
                    session.setAttribute("user", user);
                    req.setAttribute("success", "Credentials  updated successfully");

                }else {
                    req.setAttribute("error", "Failed to update credentials");
                }
                req.getRequestDispatcher("/settings.jsp").forward(req, resp);
            }else{
                String name = req.getParameter("name");
                String nic = req.getParameter("nic");
                String department = req.getParameter("department");

                if(name == null || nic == null || department == null || name.isEmpty() || nic.isEmpty() || department.isEmpty()){
                    req.setAttribute("error", "Please provide  name, nic, department");
                    req.getRequestDispatcher("/settings.jsp").forward(req, resp);
                    return;
                }

                user.setName(name);
                user.setNic(nic);
                user.setDepartment(department);

                boolean success = dao.updateUser(user);
                if(success){
                    session.setAttribute("user", user);
                    req.setAttribute("success", "Profile updated successfully");
                }else{
                    req.setAttribute("error", "Failed to update profile");
                }
                req.getRequestDispatcher("/settings.jsp").forward(req, resp);
            }
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("error", "Internal Server Error");
            req.getRequestDispatcher("/settings.jsp").forward(req, resp);
        }
    }
}
