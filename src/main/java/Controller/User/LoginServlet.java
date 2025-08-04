package Controller.User;

import Model.Builds.Build;
import Model.Builds.BuilderDAO;
import Model.Carrello.Carrello;
import Model.Carrello.CarrelloDAO;
import Model.Users.PasswordNotCorrect;
import Model.Users.User;
import Model.Users.UserDAO;
import Model.Users.UserNotFound;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
@MultipartConfig
public class LoginServlet extends HttpServlet { // gestisce il login
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserDAO userDAO = new UserDAO();
        CarrelloDAO carrelloDAO = new CarrelloDAO();
        BuilderDAO builderDAO = new BuilderDAO();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            User user = userDAO.loginUser(username,password); // la password sempre in hash
            request.getSession().setAttribute("user", user);
            int isAdmin=-1;
            if(user.isAdmin()) isAdmin=1;
            else isAdmin=0;
            Carrello carrello = carrelloDAO.loadCarrello(user);
            if(carrello==null) { // Se il carrello, presente nel database, è vuoto allora salvo quello in sessione, altrimenti ripristino quello nel database
                carrello = new Carrello();
                carrelloDAO.saveCarrello(carrello,user);
            }
            Build build = builderDAO.loadBuild(user);
            if(build==null) { // se il builder, presente nel database, è vuoto allora salvo quello in sessione, altrimenti ripristino quello nel database
                build = new Build();
                builderDAO.saveBuild(build,user);
            }
            request.getSession().setAttribute("carrello", carrello);
            request.getSession().setAttribute("build", build);
            response.getWriter().write("{\"status\":\"success\", \"admin\":" + (user.isAdmin() ? 1 : 0) + ", \"cartCount\":" + carrello.getCount() + "}");
        } catch (PasswordNotCorrect pe) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 1}");
        }
        catch (UserNotFound ue) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 2}");
        }
    }
}
