package Model.Accessori.Tappetino;

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

public class TappetinoDAO {
    public List<Tappetino> getAccessori() {
        List<Tappetino> tappetini = new ArrayList<>();
        try {
            AccessorioDAO accessorioDAO=new AccessorioDAO();
            HashMap<Integer, Accessorio> accessori=accessorioDAO.getAccessori();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.TAPPETINI");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Accessorio accessorio=accessori.get(rs.getInt(1));
                if(accessorio==null) throw new AccessorioNotFound();
                tappetini.add(new Tappetino(rs.getInt(1),accessorio.getMarca(),accessorio.getModello(),accessorio.getPrezzo(),accessorio.getDisponibilita(),accessorio.getSconto(),rs.getBoolean(2),rs.getDouble(3),rs.getDouble(4)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tappetini;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO IN (SELECT TAPPETINI.ID_ACCESSORIO FROM Build_Your_Dream.TAPPETINI) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public Tappetino getPezzo(int id) {
        Tappetino tappetino = null;
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            Accessorio accessorio = accessorioDAO.getAccessorioFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.TAPPETINI where ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                tappetino = new Tappetino(rs.getInt(1), accessorio.getMarca(), accessorio.getModello(), accessorio.getPrezzo(), accessorio.getDisponibilita(), accessorio.getSconto(), rs.getBoolean(2), rs.getDouble(3), rs.getDouble(4));
            } else {
                throw new AccessorioNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tappetino;
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps= conn.prepareStatement("DELETE FROM Build_Your_Dream.TAPPETINI WHERE ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.delete(id);
            FotoDAO fotoDAO=new FotoDAO();
            fotoDAO.removeFoto(id,"fotoAccessori","Tappetini",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(Tappetino tappetino) {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.update(tappetino);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.TAPPETINI SET LED=?, LUNGHEZZA=?, LARGHEZZA=? WHERE ID_ACCESSORIO=?");
            ps.setBoolean(1,tappetino.isLed());
            ps.setDouble(2,tappetino.getLunghezza());
            ps.setDouble(3,tappetino.getLarghezza());
            ps.setInt(4,tappetino.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newTappetino(Tappetino tappetino) throws IDAlreadyRegistred {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.newAccessorio(tappetino);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.TAPPETINI VALUES (?,?,?,?)");
            ps.setInt(1,tappetino.getID());
            ps.setBoolean(2,tappetino.isLed());
            ps.setDouble(3,tappetino.getLunghezza());
            ps.setDouble(4,tappetino.getLarghezza());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
