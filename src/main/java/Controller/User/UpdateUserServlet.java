package Controller.User;

import Model.Users.User;
import Model.Users.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/UpdateUserData") // gestisce il cambio di informazioni personali, tranne il username
public class UpdateUserServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome=request.getParameter("nome");
        String cognome=request.getParameter("cognome");
        String email=request.getParameter("email");
        String telefono=request.getParameter("nTelefono");
        String dateOfBirth=request.getParameter("dataDiNascita");
        if(nome.isEmpty() || cognome.isEmpty() || email.isEmpty() || telefono.isEmpty() || dateOfBirth.isEmpty()) {
            sendRequest("Uno dei parametri è vuoto, controlla e riprova",request,response);
            return;
        }
        Date date=Date.valueOf(dateOfBirth);
        Date today=new Date(System.currentTimeMillis());
        if(date.after(today)) {
            sendRequest("La data inserita è nel futuro, controlla e riprova",request,response);
            return;
        }
        if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            sendRequest("L'email non è valida",request,response);
            return;
        }
        // Validazione numero di telefono
        // Accetta formati: solo numeri (es. 3471234567) o con prefisso internazionale (es. +39 3471234567)
        if (!telefono.matches("^(\\+\\d{1,3}\\s?)?\\d{8,15}$")) {
            sendRequest("Il numero di telefono non è valido. Usa formato: 3471234567 o +39 3471234567", request, response);
            return;
        }
        // Validazione nome e cognome (solo lettere, spazi e apostrofi)
        if (!nome.matches("^[A-Za-zÀ-ÿ'\\s]{2,30}$")) {
            sendRequest("Il nome deve contenere solo lettere (minimo 2, massimo 30 caratteri)", request, response);
            return;
        }

        if (!cognome.matches("^[A-Za-zÀ-ÿ'\\s]{2,30}$")) {
            sendRequest("Il cognome deve contenere solo lettere (minimo 2, massimo 30 caratteri)", request, response);
            return;
        }
        UserDAO userDAO=new UserDAO();
        User user=(User) request.getSession().getAttribute("user");
        userDAO.updateUser(user,nome,cognome,telefono,email,date);
        user=userDAO.getUser(user.getUsername());
        request.getSession().setAttribute("user",user);
        sendRequest("Dati aggiornati con successo",request,response);
    }

    public void sendRequest(String message, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("updateMessage",message);
        request.setAttribute("option","yourdata");
        request.getRequestDispatcher("/user/user.jsp").forward(request,response);
    }
}
