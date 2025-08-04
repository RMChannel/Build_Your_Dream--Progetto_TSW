package Controller.Orders;

import Model.Accessori.Accessorio;
import Model.Carrello.Carrello;
import Model.Carrello.Item;
import Model.Pezzi.Pezzo;
import Model.PreBuilts.PreBuilt;
import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/chartToOrder")
public class ChartToOrderServlet extends HttpServlet { // gestisce la conversione da carrello a ordine
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user=(User) request.getSession().getAttribute("user");
        if(user==null) {
            response.getWriter().write("{\"status\": \"failed\",\"message\": \"Per poter ordinare devi essere registrato\"}");
            return;
        }
        Carrello carrello=(Carrello) request.getSession().getAttribute("carrello");
        if(carrello==null || carrello.isEmpty()) {
            response.getWriter().write("{\"status\": \"failed\",\"message\": \"Il carrello è vuoto\"}");
            return;
        }
        ArrayList<Item> objects=carrello.getObjects();
        for(Item item:objects) {
            if(item.getObject() instanceof Pezzo pezzo) {
                if(item.getQuantity()>pezzo.getDisponibilita()) {
                    response.getWriter().write("{\"status\": \"failed\",\"message\": \"La quantità di uno dei pezzi non è disponibile\"}");
                    return;
                }
            }
            else if(item.getObject() instanceof Accessorio accessorio) {
                if(item.getQuantity()>accessorio.getDisponibilita()) {
                    response.getWriter().write("{\"status\": \"failed\",\"message\": \"La quantità di uno degli accessori non è disponibile\"}");
                    return;
                }
            }
            else if(item.getObject() instanceof PreBuilt preBuilt) {
                if(item.getQuantity()>preBuilt.getDisponibilita()) {
                    response.getWriter().write("{\"status\": \"failed\",\"message\": \"La quantità di uno dei PreBuilt non è disponibile\"}");
                    return;
                }
            }
        }
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
