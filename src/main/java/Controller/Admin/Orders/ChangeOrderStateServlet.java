package Controller.Admin.Orders;

import Model.Orders.OrderDAO;
import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/changeOrderState")
public class ChangeOrderStateServlet extends HttpServlet { //gestisce il cambio di status dell'ordine da parte dell'admin
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user=(User) request.getSession().getAttribute("user");
        if(user==null || !user.isAdmin()) {
            response.sendError(405);
            return;
        }
        int ordineId=0;
        int stato=0;
        try {
            ordineId=Integer.parseInt(request.getParameter("ordineId"));
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Ordine ID non valido\"}");
            return;
        }
        try {
            stato=Integer.parseInt(request.getParameter("stato"));
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Stato non valido\"}");
            return;
        }
        if(stato<-2 || stato>2) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Stato non valido\"}");
            return;
        }
        OrderDAO orderDAO=new OrderDAO();
        orderDAO.changeStateOfOrder(ordineId,stato);
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
