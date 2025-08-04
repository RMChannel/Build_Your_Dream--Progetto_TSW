package Controller.User;

import Model.Users.PasswordNotCorrect;
import Model.Users.PasswordNotLongEnough;
import Model.Users.User;
import Model.Users.UserDAO;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.io.IOException;

@MultipartConfig
@WebServlet("/userPage/changePassword")
public class ChangePasswordServlet extends HttpServlet { // gestisce il cambio di password
    public void doPost(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response) throws IOException {
        String oldPassword=request.getParameter("oldPassword");
        String newPassword=request.getParameter("newPassword");
        String confirmNewPassword=request.getParameter("confirmNewPassword");
        if(oldPassword==null || newPassword==null || confirmNewPassword==null) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 0}");
            return;
        }
        else if(!newPassword.equals(confirmNewPassword)) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 1}");
            return;
        }
        UserDAO userDAO=new UserDAO();
        User user= (User) request.getSession().getAttribute("user"); // controlla che l'utente è effettivamente loggato
        if(user==null) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 3}");
            return;
        }
        try {
            userDAO.changePassword(oldPassword,newPassword,user);
        } catch (PasswordNotLongEnough pl) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 2}");
            return;
        }
        catch (PasswordNotCorrect p) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 4}");
            return;
        }
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
