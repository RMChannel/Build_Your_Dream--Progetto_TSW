package Model.Pezzi.Case;

import Database.DB;
import Foto.FotoDAO;
import Model.Pezzi.Pezzo;
import Model.Pezzi.PezzoDAO;
import Model.Pezzi.PezzoNotFound;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

public class CaseDAO {
    public List<Case> getCases() {
        List<Case> cases=new ArrayList<>();
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            HashMap<Integer, Pezzo> pezzi = pezzoDAO.getPezzi();
            Connection conn= DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.CASE");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pezzo pezzo=pezzi.get(rs.getInt(1));
                if(pezzo==null) throw new PezzoNotFound();
                cases.add(new Case(pezzo.getID(),pezzo.getMarca(),pezzo.getModello(),pezzo.getPrezzo(),pezzo.getDisponibilita(),pezzo.getSconto(),rs.getString(2),rs.getDouble(3),rs.getDouble(4),rs.getDouble(5),rs.getDouble(6),rs.getString(7)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return cases;
    }

    public List<String> getAllMarche() {
        ArrayList<String> marche=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO IN (SELECT `CASE`.ID_PEZZO FROM Build_Your_Dream.CASE) ORDER BY MARCA");
            ResultSet rsCase=ps.executeQuery();
            while(rsCase.next()){
                marche.add(rsCase.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllCategorie() {
        ArrayList<String> categorie=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select DISTINCT CATEGORIA from Build_Your_Dream.CASE ORDER BY CATEGORIA");
            ResultSet rsCase=ps.executeQuery();
            while(rsCase.next()){
                categorie.add(rsCase.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        categorie.sort(String.CASE_INSENSITIVE_ORDER);
        return categorie;
    }

    public Case getPezzo(int id) {
        Case c = null;
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            Pezzo pezzo = pezzoDAO.getPezzoFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.CASE where ID_PEZZO=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = new Case(pezzo.getID(), pezzo.getMarca(), pezzo.getModello(), pezzo.getPrezzo(), pezzo.getDisponibilita(), pezzo.getSconto(), rs.getString(2), rs.getDouble(3), rs.getDouble(4), rs.getDouble(5), rs.getDouble(6), rs.getString(7));
            } else {
                throw new PezzoNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return c;
    }

    public void update(Case c) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.update(c);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.`CASE` SET CATEGORIA=?, ALTEZZA=?, LARGHEZZA=?, PROFONDITA=?, PESO=?, DOTAZIONE=? WHERE ID_PEZZO=?");
            ps.setString(1, c.getCategoria());
            ps.setDouble(2, c.getAltezza());
            ps.setDouble(3, c.getLarghezza());
            ps.setDouble(4, c.getProfondita());
            ps.setDouble(5, c.getPeso());
            ps.setString(6, c.getDotazione());
            ps.setInt(7, c.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.CASE where ID_PEZZO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoPezzi","Case",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newCase(Case c) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.newPezzo(c);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.CASE VALUES (?,?,?,?,?,?,?)");
            ps.setInt(1, c.getID());
            ps.setString(2, c.getCategoria());
            ps.setDouble(3, c.getAltezza());
            ps.setDouble(4, c.getLarghezza());
            ps.setDouble(5, c.getProfondita());
            ps.setDouble(6, c.getPeso());
            ps.setString(7, c.getDotazione());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
