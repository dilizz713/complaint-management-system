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

@WebServlet("/app/v1/user")
public class UserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        BasicDataSource ds = DBConnection.getDataSource();
        UserDAO dao = new UserDAO(ds);

        String change = req.getParameter("change");

        try{
            /*----------------------                  DELETE USER             -------------------   */
            if("delete".equals(change)){
                boolean deleted = dao.deleteUser(user.getId());

                if(deleted){
                    session.invalidate();
                    resp.sendRedirect(req.getContextPath() + "/view/index.jsp");
                }else{
                    req.setAttribute("error", "Failed to delete user");
                    req.getRequestDispatcher("/view/settings.jsp").forward(req, resp);
                }

                /*----------------------                  UPDATE USER EMAIL AND PASSWORD         -------------------   */
            }else if("credentials".equals(change)){
                String newEmail = req.getParameter("email");
                String newPassword = req.getParameter("password");

                if(newEmail == null || newEmail.isEmpty() && (newPassword == null || newPassword.isEmpty())){
                    req.setAttribute("error", "Please provide  email or password");
                    req.getRequestDispatcher("/view/settings.jsp").forward(req, resp);
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
                req.getRequestDispatcher("/view/settings.jsp").forward(req, resp);

                /*----------------------                  UPDATE USER  DETAILS          -------------------   */
            }else{
                String name = req.getParameter("name");
                String nic = req.getParameter("nic");
                String department = req.getParameter("department");

                if(name == null || nic == null || department == null || name.isEmpty() || nic.isEmpty() || department.isEmpty()){
                    req.setAttribute("error", "Please provide  name, nic, department");
                    req.getRequestDispatcher("/view/settings.jsp").forward(req, resp);
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
                req.getRequestDispatcher("/view/settings.jsp").forward(req, resp);
            }
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("error", "Internal Server Error");
            req.getRequestDispatcher("/view/settings.jsp").forward(req, resp);
        }
    }
}
