package Controller.User;

import Model.Builds.Build;
import Model.Builds.BuilderDAO;
import Model.Carrello.Carrello;
import Model.Carrello.CarrelloDAO;
import Model.Users.EmailAlreadyRegistred;
import Model.Users.User;
import Model.Users.UserDAO;
import Model.Users.UsernameAlreadyRegistred;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet { // gestisce la registrazione dell'utente
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String name= request.getParameter("name");
        String lastname= request.getParameter("lastname");
        String dateOfBirth= request.getParameter("dateOfBirth");
        String email= request.getParameter("email");
        String phone= request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        if(username.isEmpty() || name.isEmpty() || lastname.isEmpty() || dateOfBirth.isEmpty() || email.isEmpty() || phone.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("errorRegister", 1);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        Date date=Date.valueOf(dateOfBirth);
        Date today=new Date(System.currentTimeMillis()); //Controllo se la data di nascita inserita è antecedente ad oggi
        if(date.after(today)) {
            request.setAttribute("errorRegister", 2);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        else if(!password.equals(confirmPassword)) {
            request.setAttribute("errorRegister", 3);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        else if(!phone.substring(1).matches("^(\\+\\d+\\s*)?\\d{10}$") && !phone.matches("^\\d{10}$")) {
            request.setAttribute("errorRegister", 6);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        else if (!email.matches("^(?=.{1,64}@)[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            request.setAttribute("errorRegister", 7);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        try {
            UserDAO userDAO = new UserDAO();
            User user=new User(username,password,name,lastname,email,phone,date,false);
            userDAO.registerUser(user);
            request.getSession().setAttribute("user", user);
            Build build= (Build) request.getSession().getAttribute("build");
            if(build!=null) {
                BuilderDAO builderDAO = new BuilderDAO();
                builderDAO.saveBuild(build,user);
            }
            Carrello carrello= (Carrello) request.getSession().getAttribute("carrello");
            if(carrello!=null) {
                CarrelloDAO carrelloDAO = new CarrelloDAO();
                carrelloDAO.saveCarrello(carrello,user);
            }
        } catch (UsernameAlreadyRegistred ue) {
            request.setAttribute("errorRegister", 4);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        catch (EmailAlreadyRegistred ee) {
            request.setAttribute("errorRegister", 5);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        request.getRequestDispatcher("index.jsp").forward(request, response);
        return;
    }
}
