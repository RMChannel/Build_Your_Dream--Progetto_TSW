package Controller.Carrello;

import Model.Carrello.Carrello;
import Model.Carrello.CarrelloDAO;
import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.DecimalFormat;

@WebServlet("/UpdateQuantitaCarrello")
public class UpdateQuantityCarrelloServlet extends HttpServlet { //gestisce l'aumento o diminuzione della quantita' di un prodotto nel carrello
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        Carrello carrello = (Carrello) request.getSession().getAttribute("carrello");
        String typeProdotto;
        int idProdotto;
        String action;
        // Gestione JSON
        if ("application/json".equals(request.getContentType())) {
            StringBuilder sb = new StringBuilder();
            String line;
            try (java.io.BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }
            String body = sb.toString();
            org.json.JSONObject json = new org.json.JSONObject(body);
            typeProdotto = json.optString("typeProdotto");
            idProdotto = json.optInt("idProdotto", 0);
            action = json.optString("action");
        } else {
            typeProdotto = request.getParameter("typeProdotto");
            idProdotto = request.getParameter("idProdotto") != null ? Integer.parseInt(request.getParameter("idProdotto")) : 0;
            action = request.getParameter("action");
        }

        boolean reload = false;
        int newQuantity = -1;
        String message = null;
        try {
            if ("decrementa".equals(action)) {
                carrello.removeFromChart(idProdotto, typeProdotto);
                int afterQuantity = carrello.getQuantity(idProdotto, typeProdotto);
                if (afterQuantity == 0) {
                    reload = true;
                } else {
                    newQuantity = afterQuantity;
                }
            } else if ("incrementa".equals(action)) {
                int disponibilita = carrello.getDisponibilita(idProdotto, typeProdotto);
                int currentQuantity = carrello.getQuantity(idProdotto, typeProdotto);
                if (currentQuantity < disponibilita) {
                    carrello.addCountToItem(idProdotto, typeProdotto);
                    newQuantity = carrello.getQuantity(idProdotto, typeProdotto);
                } else {
                    message = "Quantità massima raggiunta";
                    newQuantity = currentQuantity;
                }
            } else {
                message = "Azione non valida";
            }
            User user = (User) request.getSession().getAttribute("user");
            if (user != null) {
                CarrelloDAO carrelloDAO = new CarrelloDAO();
                carrelloDAO.saveCarrello(carrello, user);
            }
            org.json.JSONObject result = new org.json.JSONObject();
            result.put("status", message == null ? "success" : "error");
            if (reload) result.put("reload", true);
            if (newQuantity >= 0) result.put("newQuantity", newQuantity);
            if (message != null) result.put("message", message);
            result.put("cartCount", carrello.getCount());
            DecimalFormat df=new DecimalFormat("0.00");
            result.put("totale",df.format(carrello.getTotale())+"€");
            response.getWriter().write(result.toString());
        } catch (Exception e) {
            org.json.JSONObject error = new org.json.JSONObject();
            error.put("status", "error");
            error.put("message", "Errore interno: " + e.getMessage());
            response.getWriter().write(error.toString());
        }
    }
}
