package Controller.Orders;

import Model.Carrello.Carrello;
import Model.Users.Carte.Carta;
import Model.Users.Carte.CartaDAO;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/orderPage")
public class OrderPageServlet extends HttpServlet { // carica la pagina dopo aver effettuato l'ordine
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User user= (User) request.getSession().getAttribute("user");
        Carrello carrello= (Carrello) request.getSession().getAttribute("carrello");
        if(user==null || carrello==null || carrello.isEmpty()) {
            response.sendError(405);
            return;
        }
        CartaDAO cartaDAO=new CartaDAO();
        List<Carta> carte=cartaDAO.getAllCardsFromUser(user);
        request.setAttribute("carte",carte);
        request.setAttribute("carrello",carrello);
        request.setAttribute("path",getServletContext().getRealPath("/"));
        request.getRequestDispatcher("/orders/order.jsp").forward(request,response);
    }
}