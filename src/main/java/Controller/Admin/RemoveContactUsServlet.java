package Controller.Admin;

import Model.ContactUs.ContactUsDAO;
import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/removeMessage")
public class RemoveContactUsServlet extends HttpServlet { //gestiscce la rimozione del modulo selezionato di contactus
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null || !user.isAdmin()) {
            response.sendError(405);
            return;
        }
        else {
            String temp=request.getParameter("id");
            int id=Integer.parseInt(temp);
            ContactUsDAO contactUsDAO = new ContactUsDAO();
            contactUsDAO.removeModule(id);
            response.sendError(200);
        }
    }
}
