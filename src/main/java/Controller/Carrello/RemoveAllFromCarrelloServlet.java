package Controller.Carrello;

import Model.Carrello.Carrello;
import Model.Carrello.CarrelloDAO;
import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/removeAllFromChart")
public class RemoveAllFromCarrelloServlet extends HttpServlet { // gestice la rimozione di tutti i prodotti presenti nel carrello
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session=request.getSession();
        User user= (User) session.getAttribute("user");
        Carrello carrello=new Carrello();
        if(user!=null) {
            CarrelloDAO carrelloDAO=new CarrelloDAO();
            carrelloDAO.saveCarrello(carrello,user);
        }
        session.setAttribute("carrello",carrello);
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
