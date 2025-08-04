package Model.Accessori.Headset;

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

public class HeadSetDAO {
    public List<HeadSet> getAccessori() {
        List<HeadSet> headsets = new ArrayList<>();
        try {
            AccessorioDAO accessorioDAO=new AccessorioDAO();
            HashMap<Integer, Accessorio> accessori=accessorioDAO.getAccessori();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.HEADSET"); //preparedStatement si usa per evitare MYSQL injections
            ResultSet rs=ps.executeQuery(); //rappresenta la tabella con i risultati ottenuti tramite la query
            while (rs.next()) {
                Accessorio accessorio=accessori.get(rs.getInt(1));
                if(accessorio==null) throw new AccessorioNotFound();
                headsets.add(new HeadSet(rs.getInt(1),accessorio.getMarca(),accessorio.getModello(),accessorio.getPrezzo(),accessorio.getDisponibilita(),accessorio.getSconto(),rs.getString(2),rs.getBoolean(3),rs.getString(4),rs.getBoolean(5)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return headsets;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO IN (SELECT HEADSET.ID_ACCESSORIO FROM Build_Your_Dream.HEADSET) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllCategories() {
        List<String> categorie=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CATEGORIA FROM Build_Your_Dream.HEADSET ORDER BY CATEGORIA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                categorie.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categorie;
    }

    public List<String> getAllConnectivies() {
        List<String> connectivities=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CONNECTION_TYPE FROM Build_Your_Dream.HEADSET ORDER BY CONNECTION_TYPE");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                connectivities.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connectivities;
    }

    public HeadSet getPezzo(int id) {
        HeadSet headset = null;
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            Accessorio accessorio = accessorioDAO.getAccessorioFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.HEADSET where ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                headset = new HeadSet(rs.getInt(1), accessorio.getMarca(), accessorio.getModello(), accessorio.getPrezzo(), accessorio.getDisponibilita(), accessorio.getSconto(), rs.getString(2), rs.getBoolean(3), rs.getString(4), rs.getBoolean(5));
            } else {
                throw new AccessorioNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return headset;
    }

    public void update(HeadSet headset) {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.update(headset);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.HEADSET SET CATEGORIA=?, MICROFONO=?, CONNECTION_TYPE=?, LED=? WHERE ID_ACCESSORIO=?");
            ps.setString(1, headset.getCategoria());
            ps.setBoolean(2, headset.isMicrofono());
            ps.setString(3, headset.getConnectionType());
            ps.setBoolean(4, headset.isLed());
            ps.setInt(5,headset.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.HEADSET WHERE ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.delete(id);
            FotoDAO fotoDAO=new FotoDAO();
            fotoDAO.removeFoto(id,"fotoAccessori","HeadSet",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newHeadset(HeadSet headset) throws IDAlreadyRegistred {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.newAccessorio(headset);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.HEADSET VALUES(?,?,?,?,?)");
            ps.setInt(1, headset.getID());
            ps.setString(2, headset.getCategoria());
            ps.setBoolean(3, headset.isMicrofono());
            ps.setString(4, headset.getConnectionType());
            ps.setBoolean(5, headset.isLed());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
