package Controller.Carrello;

import Model.Carrello.Carrello;
import Model.Carrello.CarrelloDAO;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/carrello")
public class CarrelloPageServlet extends HttpServlet { // carica la pagina del carrello
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Carrello carrello=(Carrello) request.getSession().getAttribute("carrello");
        if(carrello==null) {
            User user= (User) request.getSession().getAttribute("user");
            if(user!=null) {
                CarrelloDAO carrelloDAO=new CarrelloDAO();
                carrello=carrelloDAO.loadCarrello(user);
                if(carrello==null) {
                    carrello=new Carrello();
                    carrelloDAO.saveCarrello(carrello,user);
                }
            }
            else {
                carrello=new Carrello();
            }
            request.getSession().setAttribute("carrello",carrello);
        }
        request.setAttribute("carrello",carrello);
        request.setAttribute("path",getServletContext().getRealPath("/"));
        request.getRequestDispatcher("/carrello/carrello.jsp").forward(request,response);
    }
}
