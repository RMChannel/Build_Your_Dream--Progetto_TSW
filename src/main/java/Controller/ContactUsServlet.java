package Controller;

import Model.ContactUs.ContactUsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@MultipartConfig
@WebServlet("/contatti")
public class ContactUsServlet extends HttpServlet { // carica la pagina contact us
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("contactUs/contactUs.jsp").forward(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { // contolla il form inviato e, se corretto, lo invia al database
        String name=request.getParameter("name");
        String email=request.getParameter("email");
        String message=request.getParameter("message");
        if(name==null || email==null || message==null || name.isEmpty() || email.isEmpty() || message.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 0}");
            return;
        }
        if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) { // se l'email inserita non ha il formato corretto da errore
            response.getWriter().write("{\"status\": \"error\", \"code\": 2}");
            return;
        }
        ContactUsDAO contactUsDAO=new ContactUsDAO(); // crea la connessione con database
        try {
            contactUsDAO.addModule(name,email,message);
        } catch (Exception e) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 1}");
            return;
        }
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
