package Controller.Orders;

import Model.Orders.Order;
import Model.Orders.OrderDAO;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/confirmOrder")
public class ConfirmOrderServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User user= (User) request.getSession().getAttribute("user");
        if(user==null) {
            response.sendError(405);
            return;
        }
        int id=0;
        try {
            id=Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(405);
            return;
        }
        OrderDAO orderDAO=new OrderDAO();
        Order order=orderDAO.getOrderBtID(id);
        if(!order.getId_user().equals(user.getUsername())) {
            response.sendError(405);
            return;
        }
        request.setAttribute("ordine",order);
        request.setAttribute("id",id);
        request.getRequestDispatcher("/orders/confirmOrder.jsp").forward(request,response);
    }
}
