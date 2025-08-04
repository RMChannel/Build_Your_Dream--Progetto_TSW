package Model.Users.Carte;

import Controller.User.Carte.CartaNotFound;
import Database.DB;
import Model.Users.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartaDAO {
    public List<Carta> getAllCardsFromUser(User user) {
        List<Carta> cards = new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Build_Your_Dream.CARTE WHERE USERNAME = ?");
            stmt.setString(1, user.getUsername());
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                cards.add(new Carta(rs.getString(1),rs.getDate(2),rs.getString(3),rs.getString(5),rs.getString(6)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return cards;
    }

    public void addCartaToUser(User user, Carta carta) throws CardAlreadySaved, CVVLengthWrong, CardNumberLengthWrong {
        List<Carta> cards = getAllCardsFromUser(user);
        if(carta.getNumeroCarta().replace(" ","").length()!=16) throw new CardNumberLengthWrong();
        if(carta.getCVV().length()!=3) throw new CVVLengthWrong();
        for (Carta c : cards) {
            if(c.getNumeroCarta().equals(carta.getNumeroCarta())) {
                throw new CardAlreadySaved();
            }
        }
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.CARTE VALUES(?,?,?,?,?,?)");
            ps.setString(1,carta.getNumeroCarta());
            ps.setDate(2,carta.getDataDiScadenza());
            ps.setString(3,carta.getCVV());
            ps.setString(4,user.getUsername());
            ps.setString(5,carta.getNome());
            ps.setString(6,carta.getCognome());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void removeCartaFromUser(User user, Carta carta) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.CARTE WHERE NUMERO_CARTA = ? AND DATA_SCADENZA = ? AND CVV = ? AND USERNAME = ?");
            ps.setString(1,carta.getNumeroCarta());
            ps.setDate(2,carta.getDataDiScadenza());
            ps.setString(3,carta.getCVV());
            ps.setString(4,user.getUsername());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Carta getCarta(String numeroCarta, Date dataDiScadenza, String cvv, User user) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.CARTE WHERE NUMERO_CARTA = ? AND DATA_SCADENZA = ? AND CVV = ? AND USERNAME = ?");
            ps.setString(1,numeroCarta);
            ps.setDate(2,dataDiScadenza);
            ps.setString(3,cvv);
            ps.setString(4,user.getUsername());
            ResultSet rs=ps.executeQuery();
            if(rs.next()) {
                return new Carta(numeroCarta,dataDiScadenza,cvv,rs.getString(5),rs.getString(6));
            }
            else throw new CartaNotFound();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
