package Controller.Admin.Users;

import Model.Users.User;
import Model.Users.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/updateUserAdmin")
public class UpdateUserServlet extends HttpServlet { // gestisce il cambio di dati di un utente da parte dell'admin
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDAO=new UserDAO();
        User user= (User) request.getSession().getAttribute("user");
        if(user==null || !user.isAdmin()){
            response.sendError(405);
            return;
        }
        String username = request.getParameter("username");
        String originalUsername = request.getParameter("originalUsername");
        if(!originalUsername.equals(username)) {
            userDAO.updateUsername(originalUsername, username);
        }
        String nome=request.getParameter("nome");
        String cognome=request.getParameter("cognome");
        String email=request.getParameter("email");
        if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 2}");
            return;
        }
        String telefono=request.getParameter("nTelefono");
        String dateOfBirth=request.getParameter("dataDiNascita");
        boolean admin=Boolean.parseBoolean(request.getParameter("isAdmin"));
        if(nome.isEmpty() || cognome.isEmpty() || email.isEmpty() || telefono.isEmpty() || dateOfBirth.isEmpty()) {
            sendRequest(0,response);
            return;
        }
        Date date=Date.valueOf(dateOfBirth);
        Date today=new Date(System.currentTimeMillis());
        if(date.after(today)) {
            sendRequest(1,response);
            return;
        }
        else if(!telefono.substring(1).matches("^(\\\\+\\\\d+\\\\s*)?\\\\d{10}$") && !telefono.matches("^\\d{10}$")) {
            sendRequest(3,response);
        }
        user=userDAO.getUser(username);
        userDAO.updateUser(user,nome,cognome,telefono,email,date,admin);
        sendRequest(2,response);
    }

    public void sendRequest(int message,HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        switch(message){
            case 0: case 1: case 3:
                response.getWriter().write("{\"status\": \"error\", \"code\": " + message + "}");
                break;
            case 2:
                response.getWriter().write("{\"status\": \"success\"}");
                break;
        }
    }
}
