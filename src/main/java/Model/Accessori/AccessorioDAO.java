package Model.Accessori;

import Database.DB;
import Foto.FotoDAO;
import Model.IDAlreadyRegistred;
import Model.Pezzi.Pezzo;
import Model.QuantityNotSufficientException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class AccessorioDAO {
    public HashMap<Integer, Accessorio> getAccessori() {  //serve per ricavare tutti gli attributi di un accessorio tramite l'id. id è un Integer e Accessorio si ricava tramite l'id
        HashMap<Integer, Accessorio> accessori = new HashMap<>();
        try {
            Connection conn = DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.ACCESSORI");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                accessori.put(rs.getInt(1),new Accessorio(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getInt(6)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return accessori;
    }

    public Accessorio getAccessorioFromID(int ID) {
        Accessorio accessorio=null;
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO=?");
            ps.setInt(1,ID);
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                accessorio=new Accessorio(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getInt(6));
            }
            else throw new AccessorioNotFound();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return accessorio;
    }

    public void update(Accessorio accessorio) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.ACCESSORI SET MARCA=?, MODELLO=?, PREZZO=?, DISPONIBILITA=?, SCONTO=? WHERE ID_ACCESSORIO=?");
            ps.setString(1,accessorio.getMarca());
            ps.setString(2,accessorio.getModello());
            ps.setDouble(3,accessorio.getPrezzo());
            ps.setInt(4,accessorio.getDisponibilita());
            ps.setInt(5,accessorio.getSconto());
            ps.setInt(6,accessorio.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int id) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO=?");
            ps.setInt(1,id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newAccessorio(Accessorio accessorio) throws IDAlreadyRegistred {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO=?");
            ps.setInt(1,accessorio.getID());
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                throw new IDAlreadyRegistred();
            }
            ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.ACCESSORI VALUES(?,?,?,?,?,?)");
            ps.setInt(1,accessorio.getID());
            ps.setString(2,accessorio.getMarca());
            ps.setString(3,accessorio.getModello());
            ps.setDouble(4,accessorio.getPrezzo());
            ps.setInt(5,accessorio.getDisponibilita());
            ps.setInt(6,accessorio.getSconto());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void decreaseQuantity(Accessorio accessorio, int quantity) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISPONIBILITA FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO=?");
            ps.setInt(1,accessorio.getID());
            ResultSet rs=ps.executeQuery();
            int disponibilita=0;
            if(rs.next()) {
                disponibilita=rs.getInt(1);
            }
            else throw new AccessorioNotFound();
            if(disponibilita-quantity<0) {
                throw new QuantityNotSufficientException();
            }
            ps=conn.prepareStatement("UPDATE Build_Your_Dream.ACCESSORI SET DISPONIBILITA=? WHERE ID_ACCESSORIO=?");
            ps.setInt(1,disponibilita-quantity);
            ps.setInt(2,accessorio.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void increaseQuantity(Accessorio accessorio, int quantity) {
        if(quantity<=0) {
            throw new QuantityNotSufficientException();
        }
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISPONIBILITA FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO=?");
            ps.setInt(1,accessorio.getID());
            ResultSet rs=ps.executeQuery();
            int disponibilita=0;
            if(rs.next()) {
                disponibilita=rs.getInt(1);
            }
            else throw new AccessorioNotFound();
            ps=conn.prepareStatement("UPDATE Build_Your_Dream.ACCESSORI SET DISPONIBILITA=? WHERE ID_ACCESSORIO=?");
            ps.setInt(1,disponibilita+quantity);
            ps.setInt(2,accessorio.getID());
            ps.executeUpdate();
        } catch (SQLException e) {

            throw new RuntimeException(e);
        }
    }
}
