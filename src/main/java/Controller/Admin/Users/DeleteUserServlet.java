package Controller.Admin.Users;

import Model.Users.User;
import Model.Users.UserDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet { //gestisce la rimozione dell'utente da parte dell'admin
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user= (User) request.getSession().getAttribute("user");
        if(user==null || !user.isAdmin()){
            response.sendError(405);
            return;
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String username=request.getParameter("username");
        UserDAO userDAO=new UserDAO();
        try {
            userDAO.removeUser(username);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"status\": \"error\"}");
            return;
        }
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
