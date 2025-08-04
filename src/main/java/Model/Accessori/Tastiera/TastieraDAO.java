package Model.Accessori.Tastiera;

import Database.DB;
import Foto.FotoDAO;
import Model.Accessori.Accessorio;
import Model.Accessori.AccessorioDAO;
import Model.Accessori.AccessorioNotFound;
import Model.IDAlreadyRegistred;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class TastieraDAO {
    public List<Tastiera> getAccessori() {
        List<Tastiera> tastiere=new ArrayList<>();
        try {
            AccessorioDAO accessorioDAO=new AccessorioDAO();
            HashMap<Integer, Accessorio> map=accessorioDAO.getAccessori();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.TASTIERA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Accessorio accessorio=map.get(rs.getInt(1));
                if(accessorio==null) throw new AccessorioNotFound();
                tastiere.add(new Tastiera(rs.getInt(1),accessorio.getMarca(),accessorio.getModello(),accessorio.getPrezzo(),accessorio.getDisponibilita(),accessorio.getSconto(),rs.getString(2),rs.getString(3),rs.getBoolean(4),rs.getBoolean(5),rs.getString(6),rs.getDouble(7),rs.getDouble(8),rs.getDouble(9)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tastiere;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO IN (SELECT TASTIERA.ID_ACCESSORIO FROM Build_Your_Dream.TASTIERA) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllLayouts() {
        List<String> layouts=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT LAYOUT FROM Build_Your_Dream.TASTIERA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                layouts.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return layouts;
    }

    public List<String> getAllConnecttivities() {
        List<String> connectivities=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CONNETTIVITA FROM Build_Your_Dream.TASTIERA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                connectivities.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connectivities;
    }

    public List<String> getAllCategorie() {
        List<String> categorie=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CATEGORIA FROM Build_Your_Dream.TASTIERA ORDER BY CATEGORIA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                categorie.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categorie;
    }

    public Tastiera getPezzo(int id) {
        Tastiera tastiera = null;
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            Accessorio accessorio = accessorioDAO.getAccessorioFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.TASTIERA where ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                tastiera = new Tastiera(rs.getInt(1), accessorio.getMarca(), accessorio.getModello(), accessorio.getPrezzo(), accessorio.getDisponibilita(), accessorio.getSconto(), rs.getString(2), rs.getString(3), rs.getBoolean(4), rs.getBoolean(5), rs.getString(6), rs.getDouble(7), rs.getDouble(8), rs.getDouble(9));
            } else {
                throw new AccessorioNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tastiera;
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.TASTIERA WHERE ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoAccessori","Tastiere",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(Tastiera tastiera) {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.update(tastiera);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.TASTIERA SET CATEGORIA=?, LAYOUT=?, COMPATTA=?, LED=?, CONNETTIVITA=?, LARGHEZZA=?, LUNGHEZZA=?, PESO=? WHERE ID_ACCESSORIO=?");
            ps.setString(1,tastiera.getCategoria());
            ps.setString(2,tastiera.getLayout());
            ps.setBoolean(3, tastiera.isCompatta());
            ps.setBoolean(4, tastiera.isLed());
            ps.setString(5,tastiera.getConnettivita());
            ps.setDouble(6,tastiera.getLarghezza());
            ps.setDouble(7,tastiera.getLunghezza());
            ps.setDouble(8,tastiera.getPeso());
            ps.setInt(9,tastiera.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newTastiera(Tastiera tastiera) throws IDAlreadyRegistred {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.newAccessorio(tastiera);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.TASTIERA VALUES (?,?,?,?,?,?,?,?,?)");
            ps.setInt(1,tastiera.getID());
            ps.setString(2,tastiera.getCategoria());
            ps.setString(3,tastiera.getLayout());
            ps.setBoolean(4, tastiera.isCompatta());
            ps.setBoolean(5, tastiera.isLed());
            ps.setString(6,tastiera.getConnettivita());
            ps.setDouble(7,tastiera.getLarghezza());
            ps.setDouble(8,tastiera.getLunghezza());
            ps.setDouble(9,tastiera.getPeso());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
