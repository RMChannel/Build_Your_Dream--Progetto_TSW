package Controller.User.Carte;

import Model.Users.Carte.Carta;
import Model.Users.Carte.CartaDAO;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/userPage/removeCarta")
public class RemoveCartaServlet extends HttpServlet { // gestisce la rimozione di una delle carte salvate
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CartaDAO cartaDAO=new CartaDAO();
        String numeroDiCarta=request.getParameter("numeroDiCarta");
        String cvv=request.getParameter("cvv");
        String dataDiScadenza=request.getParameter("dataDiScadenza");
        Date date=Date.valueOf(dataDiScadenza);
        User user=(User) request.getSession().getAttribute("user");
        Carta carta=cartaDAO.getCarta(numeroDiCarta,date,cvv,user);
        cartaDAO.removeCartaFromUser(user,carta);
        request.setAttribute("option","yourcards");
        List<Carta> carte=cartaDAO.getAllCardsFromUser((User) request.getSession().getAttribute("user"));
        request.setAttribute("carte",carte);
        request.getRequestDispatcher("/user/user.jsp").forward(request,response);
    }
}
