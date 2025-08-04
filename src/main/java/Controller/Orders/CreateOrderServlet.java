package Controller.Orders;

import Model.Accessori.Accessorio;
import Model.Accessori.AccessorioDAO;
import Model.Carrello.Carrello;
import Model.Carrello.CarrelloDAO;
import Model.Carrello.Item;
import Model.Orders.Order;
import Model.Orders.OrderDAO;
import Model.Pezzi.Pezzo;
import Model.Pezzi.PezzoDAO;
import Model.PreBuilts.PreBuilt;
import Model.PreBuilts.PreBuiltDAO;
import Model.Users.Carte.*;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.GregorianCalendar;

@MultipartConfig
@WebServlet("/confermaOrdine")
public class CreateOrderServlet extends HttpServlet { // gestisce la creazione dell'ordine
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User user = (User) request.getSession().getAttribute("user");
        Carrello carrello = (Carrello) request.getSession().getAttribute("carrello");
        if (user == null || carrello == null || carrello.isEmpty()) {
            response.sendError(405);
            return;
        }
        // Recupero parametri spedizione
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String telefono = request.getParameter("telefono");
        String via = request.getParameter("via");
        String civicoStr = request.getParameter("civico");
        String cap = request.getParameter("cap");
        String citta = request.getParameter("citta");
        // Recupero parametri pagamento
        String cartaSalvata = request.getParameter("cartaSalvata");
        if(cartaSalvata==null) cartaSalvata="empty";
        String nuovaCarta = request.getParameter("nuovaCarta");
        String scadenza = request.getParameter("scadenza");
        String cvv = request.getParameter("cvv");
        String titolare = request.getParameter("titolare");
        Boolean salvaCarta = false;
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        java.util.Map<String, String> errors = new java.util.HashMap<>();
        int civico=0;
        // Validazione parametri spedizione
        if(request.getParameter("salvaCarta")!=null) {
            try {
                salvaCarta=Boolean.parseBoolean(request.getParameter("salvaCarta"));
            } catch (NumberFormatException e) {
                errors.put("salvaCarta", "Errore nella spunta \"salva carta\"");
            }
        }
        if (nome == null || nome.trim().length() < 2) {
            errors.put("nome", "Nome non valido");
        }
        if (cognome == null || cognome.trim().length() < 2) {
            errors.put("cognome", "Cognome non valido");
        }
        if (telefono == null || !telefono.matches("^\\d{7,11}$") ||
            !(telefono.startsWith("0") || telefono.startsWith("3")) ||
            (telefono.startsWith("3") && telefono.length() != 10) ||
            (telefono.startsWith("0") && (telefono.length() < 9 || telefono.length() > 11))) {
            errors.put("telefono", "Telefono non valido");
        }
        if (via == null || via.trim().length() < 2) {
            errors.put("via", "Via non valida");
        }
        if (civicoStr == null || civicoStr.trim().isEmpty()) {
            errors.put("civico", "Civico non valido");
        } else {
            try {
                civico=Integer.parseInt(civicoStr);
            } catch (NumberFormatException e) {
                errors.put("civico", "Civico non valido");
            }
        }
        if (cap == null || !cap.matches("^\\d{5}$")) {
            errors.put("cap", "CAP non valido");
        }
        if (citta == null || citta.trim().length() < 2) {
            errors.put("citta", "Città non valida");
        }
        // Validazione pagamento: o carta salvata o nuova carta
        boolean cartaSalvataValida = !cartaSalvata.equals("empty");
        boolean nuovaCartaValida = nuovaCarta != null && nuovaCarta.matches("^\\d{16}$") && cvv != null && cvv.matches("^\\d{3}$") && controlloScadenza(scadenza) && titolare != null && titolare.trim().length() >= 2;
        if (!cartaSalvataValida && !nuovaCartaValida) {
            errors.put("pagamento", "Dati pagamento non validi");
            if (nuovaCarta != null && !nuovaCarta.isEmpty() && !nuovaCarta.matches("^\\d{16}$")) {
                errors.put("nuovaCarta", "Numero carta non valido");
            }
            if (scadenza != null && !controlloScadenza(scadenza)) {
                errors.put("scadenza", "Scadenza non valida");
            }
            if (cvv != null && !cvv.isEmpty() && !cvv.matches("^\\d{3}$")) {
                errors.put("cvv", "CVV non valido");
            }
            if (titolare != null && !titolare.isEmpty() && titolare.trim().length() < 2) {
                errors.put("titolare", "Titolare non valido");
            }
        }
        if (!errors.isEmpty()) {
            StringBuilder sb = new StringBuilder();
            sb.append("{\"status\": \"error\", \"errors\": {");
            int i = 0;
            for (java.util.Map.Entry<String, String> entry : errors.entrySet()) {
                if (i > 0) sb.append(",");
                sb.append("\"").append(entry.getKey()).append("\": ")
                  .append("\"").append(entry.getValue()).append("\"");
                i++;
            }
            sb.append("}}");
            response.getWriter().write(sb.toString());
            return;
        }
        OrderDAO orderDAO = new OrderDAO();
        Date date=new Date(new GregorianCalendar().getTimeInMillis());
        Order order;
        if(cartaSalvataValida) {
            order=new Order(orderDAO.genNextInt(),0,date,user.getUsername(),telefono,civico,cap,via,citta,cartaSalvata,carrello);
        }
        else {
            if(salvaCarta) {
                CartaDAO cartaDAO=new CartaDAO();
                String[] nomeeCognome = titolare.split(" ");
                String newNome="";
                for(int i=0;i<(nomeeCognome.length-1);i++) newNome += nomeeCognome[i] + " ";
                String newCognome=nomeeCognome[nomeeCognome.length-1];
                String[] scadenzaArray=scadenza.split("/");
                int mese=Integer.parseInt(scadenzaArray[0]);
                int anno=Integer.parseInt(scadenzaArray[1]);
                if(anno<100) anno+=2000;
                Date newDate=Date.valueOf(LocalDate.of(anno,mese,1));
                try {
                    cartaDAO.addCartaToUser(user,new Carta(nuovaCarta,newDate,cvv,newNome,newCognome));
                } catch (CardAlreadySaved e) {
                    response.getWriter().write("{\"status\": \"error\", \"errors\": {\"carta\":\"La carta risulta già salvata\"}}");
                    return;
                } catch (CVVLengthWrong | CardNumberLengthWrong e) {
                    throw new RuntimeException(e);
                }
            }
            order=new Order(orderDAO.genNextInt(),0,date,user.getUsername(),telefono,civico,cap,via,citta,nuovaCarta,carrello);
        }
        PezzoDAO pezzoDAO=new PezzoDAO();
        AccessorioDAO accessorioDAO=new AccessorioDAO();
        PreBuiltDAO preBuiltDAO=new PreBuiltDAO();
        orderDAO.createOrder(order);
        for(Item item:carrello.getObjects()) {
            if(item.getObject() instanceof Pezzo) {
                pezzoDAO.decreaseQuantity((Pezzo) item.getObject(),item.getQuantity());
            }
            else if(item.getObject() instanceof Accessorio) {
                accessorioDAO.decreaseQuantity((Accessorio) item.getObject(),item.getQuantity());
            }
            else if(item.getObject() instanceof PreBuilt) {
                preBuiltDAO.decreaseQuantity((PreBuilt) item.getObject(),item.getQuantity());
            }
        }
        CarrelloDAO carrelloDAO=new CarrelloDAO();
        carrello=new Carrello();
        carrelloDAO.saveCarrello(carrello,user);
        request.getSession().setAttribute("carrello",carrello);
        response.getWriter().write("{\"status\": \"success\", \"id\":"+order.getCodice()+"}");
    }

    public boolean controlloScadenza(String scadenza) {
        if(scadenza==null || scadenza.isEmpty()) {
            return false;
        }
        String[] scadenzaArray=scadenza.split("/");
        if(scadenzaArray.length!=2) {
            return false;
        }
        int mese=Integer.parseInt(scadenzaArray[0]);
        int anno=Integer.parseInt(scadenzaArray[1]);
        LocalDate ld=new GregorianCalendar().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
        if(mese<1 || mese>12 || anno<(ld.getYear()-2000) || anno>100) {
            return false;
        }
        return true;
    }
}
