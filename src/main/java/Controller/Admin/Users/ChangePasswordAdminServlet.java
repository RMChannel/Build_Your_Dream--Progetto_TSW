package Controller.Admin.Users;

import Model.Users.PasswordNotLongEnough;
import Model.Users.User;
import Model.Users.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/changeUserPassword")
public class ChangePasswordAdminServlet extends HttpServlet { //gestisce il cambio di password da parte dell'admin
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null || !user.isAdmin()) {
            response.sendError(405);
            return;
        }
        String username = request.getParameter("username");
        String password = request.getParameter("newPassword");
        UserDAO userDAO = new UserDAO();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            userDAO.changePassword(username, password);
        } catch (PasswordNotLongEnough p) {
            response.getWriter().write("{\"status\": \"error\"}");
            return;
        }
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
