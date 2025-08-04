package Model.Pezzi;

import Database.DB;
import Model.Accessori.AccessorioNotFound;
import Model.QuantityNotSufficientException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class PezzoDAO {
    public HashMap<Integer,Pezzo> getPezzi() {
        HashMap<Integer,Pezzo> pezzi=new HashMap<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.PEZZI");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                pezzi.put(rs.getInt(1),new Pezzo(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getInt(6)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return pezzi;
    }

    public Pezzo getPezzoFromID(int ID) {
        Pezzo pezzo=null;
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO=?");
            ps.setInt(1,ID);
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                pezzo=new Pezzo(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getInt(6));
            }
            else throw new PezzoNotFound();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return pezzo;
    }

    public void update(Pezzo pezzo) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.PEZZI SET MARCA=?, MODELLO=?, PREZZO=?, DISPONIBILITA=?, SCONTO=? WHERE ID_PEZZO=?");
            ps.setString(1,pezzo.getMarca());
            ps.setString(2,pezzo.getModello());
            ps.setDouble(3,pezzo.getPrezzo());
            ps.setInt(4,pezzo.getDisponibilita());
            ps.setInt(5,pezzo.getSconto());
            ps.setInt(6,pezzo.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int id) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO=?");
            ps.setInt(1,id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newPezzo(Pezzo pezzo) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.PEZZI VALUES(?,?,?,?,?,?)");
            ps.setInt(1,pezzo.getID());
            ps.setString(2,pezzo.getMarca());
            ps.setString(3,pezzo.getModello());
            ps.setDouble(4,pezzo.getPrezzo());
            ps.setInt(5,pezzo.getDisponibilita());
            ps.setInt(6,pezzo.getSconto());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void decreaseQuantity(Pezzo pezzo, int quantity) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISPONIBILITA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO=?");
            ps.setInt(1,pezzo.getID());
            ResultSet rs=ps.executeQuery();
            int disponibilita=0;
            if(rs.next()) {
                disponibilita=rs.getInt(1);
            }
            else throw new PezzoNotFound();
            if(disponibilita-quantity<0) {
                throw new QuantityNotSufficientException();
            }
            ps=conn.prepareStatement("UPDATE Build_Your_Dream.PEZZI SET DISPONIBILITA=? WHERE ID_PEZZO=?");
            ps.setInt(1,pezzo.getDisponibilita()-quantity);
            ps.setInt(2,pezzo.getID());
            ps.executeUpdate();
        } catch (SQLException e) {

            throw new RuntimeException(e);
        }
    }

    public void increaseQuantity(Pezzo pezzo, int quantity) {
        if(quantity<=0) {
            throw new QuantityNotSufficientException();
        }
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISPONIBILITA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO=?");
            ps.setInt(1,pezzo.getID());
            ResultSet rs=ps.executeQuery();
            int disponibilita=0;
            if(rs.next()) {
                disponibilita=rs.getInt(1);
            }
            else throw new PezzoNotFound();
            ps=conn.prepareStatement("UPDATE Build_Your_Dream.PEZZI SET DISPONIBILITA=? WHERE ID_PEZZO=?");
            ps.setInt(1,disponibilita+quantity);
            ps.setInt(2,pezzo.getID());
            ps.executeUpdate();
        } catch (SQLException e) {

            throw new RuntimeException(e);
        }
    }
}
