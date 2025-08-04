package Controller.User.Carte;

import Model.Users.Carte.*;
import Model.Users.User;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/userPage/addCarta")
@MultipartConfig
public class AddCartaServlet extends HttpServlet { // gestisce l'aggiunta di una nuova carta
    public void doGet(HttpServletRequest request, HttpServletResponse response) {

    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user=(User) request.getSession().getAttribute("user");
        String numeroCarta=request.getParameter("cardNumber");
        int mese=Integer.parseInt(request.getParameter("expiryMonth"));
        int anno=Integer.parseInt(request.getParameter("expiryYear"));
        String cvv=request.getParameter("cvv");
        String nome=request.getParameter("firstName");
        String cognome=request.getParameter("lastName");
        Date data= new Date(anno-1900,mese-1,1);
        Carta carta=new Carta(numeroCarta,data,cvv,nome,cognome);
        CartaDAO cartaDAO=new CartaDAO();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            cartaDAO.addCartaToUser(user,carta);
            response.getWriter().write("{\"status\": \"success\"}");
        } catch (CardAlreadySaved e) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 1}");
        } catch (CVVLengthWrong e) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 2}");
        } catch (CardNumberLengthWrong e) {
            response.getWriter().write("{\"status\": \"error\", \"code\": 3}");
        }
    }
}
