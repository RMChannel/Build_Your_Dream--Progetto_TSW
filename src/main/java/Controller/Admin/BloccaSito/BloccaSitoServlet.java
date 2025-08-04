package Controller.Admin.BloccaSito;

import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/bloccaSito")
public class BloccaSitoServlet extends HttpServlet { //permette di bloccare e sbloccare il sito
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null || !user.isAdmin()) {
            response.sendError(405);
        }
        else {
            BloccaSitoFilter.setSitoBloccato();
            response.sendRedirect(request.getContextPath()+"/adminPage");
        }
    }
}
