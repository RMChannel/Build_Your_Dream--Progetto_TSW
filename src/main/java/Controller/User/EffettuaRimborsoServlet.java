package Controller.User;

import Model.Orders.Order;
import Model.Orders.OrderDAO;
import Model.Users.User;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/rimborsaOrdine")
@MultipartConfig
public class EffettuaRimborsoServlet extends HttpServlet { // gestisce i rimborsi degli ordini
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user=(User) request.getSession().getAttribute("user");
        if(user==null) {
            response.sendError(405);
            return;
        }
        int id=0; // id ordine
        try {
            id=Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"failed\", \"message\": \"id non valido\"}");
            return;
        }
        OrderDAO orderDAO=new OrderDAO();
        List<Order> orders=orderDAO.getOrdersForUser(user);
        boolean ordine=true;
        for(Order order:orders) {
            if(order.getCodice()==id) {
                ordine=false;
                break;
            }
        }
        if(ordine) {
            response.sendError(405);
            return;
        }
        orderDAO.effettuaRimborsoOrdine(orderDAO.getOrderBtID(id),-1);
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
