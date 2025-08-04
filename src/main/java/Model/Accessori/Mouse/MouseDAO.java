package Model.Accessori.Mouse;

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

public class MouseDAO {
    public List<Mouse> getAccessori() {
        List<Mouse> mouses=new ArrayList<>();
        try {
            AccessorioDAO dao=new AccessorioDAO();
            HashMap<Integer,Accessorio> map=dao.getAccessori();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.MOUSE");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Accessorio accessorio=map.get(rs.getInt(1));
                if(accessorio==null) throw new AccessorioNotFound();
                mouses.add(new Mouse(rs.getInt(1),accessorio.getMarca(),accessorio.getModello(),accessorio.getPrezzo(),accessorio.getDisponibilita(),accessorio.getSconto(),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getInt(6),rs.getDouble(7),rs.getBoolean(8)));
            }
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
        return mouses;
    }

    public List<String> getAllConnections() {
        List<String> connections=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MOUSE.CONNECTION_TYPE FROM Build_Your_Dream.MOUSE");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                connections.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connections;
    }

    public List<String> getAllForme() {
        List<String> forme=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MOUSE.FORMA FROM Build_Your_Dream.MOUSE ORDER BY MOUSE.FORMA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                forme.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return forme;
    }

    public List<String> getAllCategorie() {
        List<String> categorie=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MOUSE.CATEGORIA FROM Build_Your_Dream.MOUSE ORDER BY MOUSE.CATEGORIA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                categorie.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categorie;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO IN (SELECT MOUSE.ID_ACCESSORIO FROM Build_Your_Dream.MOUSE) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public Mouse getPezzo(int id) {
        Mouse mouse = null;
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            Accessorio accessorio = accessorioDAO.getAccessorioFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.MOUSE where ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                mouse = new Mouse(rs.getInt(1), accessorio.getMarca(), accessorio.getModello(), accessorio.getPrezzo(), accessorio.getDisponibilita(), accessorio.getSconto(), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getDouble(7), rs.getBoolean(8));
            } else {
                throw new AccessorioNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return mouse;
    }

    public void newMouse(Mouse mouse) throws IDAlreadyRegistred {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.newAccessorio(mouse);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.MOUSE VALUES (?,?,?,?,?,?,?,?)");
            ps.setInt(1,mouse.getID());
            ps.setString(2,mouse.getCategoria());
            ps.setString(3,mouse.getConnectionType());
            ps.setString(4,mouse.getForma());
            ps.setString(5,mouse.getSensore());
            ps.setInt(6,mouse.getDPI());
            ps.setDouble(7,mouse.getPeso());
            ps.setBoolean(8,mouse.isLed());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.MOUSE WHERE ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            AccessorioDAO accessorioDAO=new AccessorioDAO();
            accessorioDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoAccessori","Mouse",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(Mouse mouse) {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.update(mouse);
            Connection conn = DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.MOUSE SET CATEGORIA=?, CONNECTION_TYPE=?, FORMA=?, SENSORE=?, DPI=?, PESO=?, LED=? WHERE ID_ACCESSORIO=?");
            ps.setString(1, mouse.getCategoria());
            ps.setString(2, mouse.getConnectionType());
            ps.setString(3, mouse.getForma());
            ps.setString(4, mouse.getSensore());
            ps.setInt(5,mouse.getDPI());
            ps.setDouble(6, mouse.getPeso());
            ps.setBoolean(7,mouse.isLed());
            ps.setInt(8,mouse.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
