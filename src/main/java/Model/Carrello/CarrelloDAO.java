package Model.Carrello;

import Database.DB;
import Model.Users.User;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CarrelloDAO {
    public byte[] serializzaCarrello(Carrello carrello) throws Exception {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ObjectOutputStream oos = new ObjectOutputStream(bos);
        oos.writeObject(carrello);
        oos.flush();
        return bos.toByteArray();
    }

    public void saveCarrello(Carrello carrello, User user) {
        try {
            Connection conn= DB.getConn();
            if(loadCarrello(user)==null) { // se l'utente non ha ancora un carrello salvato, crea l'oggetto carrello nel DB
                PreparedStatement ps=conn.prepareStatement("insert into Build_Your_Dream.CARRELLO values(?,?)");
                ps.setString(1,user.getUsername());
                ps.setBytes(2,serializzaCarrello(carrello));
                ps.executeUpdate();
            }
            else { // altrimenti, aggiorna quello già presente nel DB
                PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.CARRELLO SET dati=? WHERE USER_ID=?");
                ps.setBytes(1,serializzaCarrello(carrello));
                ps.setString(2,user.getUsername());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Carrello loadCarrello(User user) { //serve per recuperare gli oggetti del carrello salvati nel DB
        Carrello carrello = null;
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.CARRELLO where USER_ID=?");
            ps.setString(1,user.getUsername());
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                byte[] dati = rs.getBytes("dati");
                ByteArrayInputStream bis = new ByteArrayInputStream(dati);
                ObjectInputStream ois = new ObjectInputStream(bis);
                carrello = (Carrello) ois.readObject();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return carrello;
    }
}
