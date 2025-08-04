package Controller.Admin.Users;

import Model.Users.EmailAlreadyRegistred;
import Model.Users.User;
import Model.Users.UserDAO;
import Model.Users.UsernameAlreadyRegistred;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/newUser")
public class NewUserServlet extends HttpServlet { // gestisce la creazione di un nuovo utente da parte dell'admin
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !user.isAdmin()) {
            response.sendError(405);
            return;
        }
        String username = request.getParameter("username");
        String nome=request.getParameter("nome");
        String cognome=request.getParameter("cognome");
        String dataDiNascita=request.getParameter("dataDiNascita");
        Date date=Date.valueOf(dataDiNascita);
        Date today=new Date(System.currentTimeMillis());
        String email=request.getParameter("email");
        if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 2}");
            return;
        }
        String nTelefono=request.getParameter("nTelefono");
        String password=request.getParameter("password");
        boolean isAdmin=Boolean.parseBoolean(request.getParameter("isAdmin"));
        String message="";
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        if(username.isEmpty() || nome.isEmpty() || cognome.isEmpty() || dataDiNascita.isEmpty() || email.isEmpty() || nTelefono.isEmpty() || password.isEmpty()) {
            message="Uno dei parametri è vuoto, controlla e riprova";
        }
        else if(password.length()<8) {
            message="La password dev'essere lunga almeno 8 caratteri";
        }
        else if(!nTelefono.substring(1).matches("^(\\\\+\\\\d+\\\\s*)?\\\\d{10}$") && !nTelefono.matches("^\\d{10}$")) {
            message="Il numero di telefono non è in un formato corretto, o +39 1234567890 o 1234567890";
        }
        else if(date.after(today)) {
            message="La data inserita è successiva a quella attuale";
        }
        if(message.isEmpty()) {
            user=new User(username,password,nome,cognome,email,nTelefono,date,isAdmin);
            UserDAO userDAO = new UserDAO();
            try {
                userDAO.registerUser(user);
            } catch (UsernameAlreadyRegistred e) {
                response.getWriter().write("{\"status\": \"error\", \"message\": \"L'username inserito è già registrato\"}");
                return;
            } catch (EmailAlreadyRegistred e) {
                response.getWriter().write("{\"status\": \"error\", \"message\": \"L'email inserita è già registrata\"}");
                return;
            }
            response.getWriter().write("{\"status\": \"success\"}");
        }
        else {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"" + message + "\"}");
        }
    }
}
