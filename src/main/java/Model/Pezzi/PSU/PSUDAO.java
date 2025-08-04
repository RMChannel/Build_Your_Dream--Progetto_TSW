package Model.Pezzi.PSU;

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
import java.util.List;

public class PSUDAO {
    public List<PSU> getPezzi() {
        List<PSU> psus=new ArrayList<>();
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            HashMap<Integer, Pezzo> pezzi=pezzoDAO.getPezzi();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.PSU");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Pezzo pezzo=pezzi.get(rs.getInt(1));
                if(pezzo==null) throw new PezzoNotFound();
                psus.add(new PSU(rs.getInt(1),pezzo.getMarca(),pezzo.getModello(),pezzo.getPrezzo(),pezzo.getDisponibilita(),pezzo.getSconto(),rs.getString(2),rs.getInt(3),rs.getString(4),rs.getBoolean(5),rs.getDouble(6)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return psus;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO IN (SELECT PSU.ID_PEZZO FROM Build_Your_Dream.PSU) ORDER BY MARCA");
            ResultSet rsPSU=ps.executeQuery();
            while(rsPSU.next()){
                marche.add(rsPSU.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllCategories() {
        List<String> categorie=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CATEGORIA FROM Build_Your_Dream.PSU ORDER BY CATEGORIA");
            ResultSet rsPSU=ps.executeQuery();
            while(rsPSU.next()){
                categorie.add(rsPSU.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categorie;
    }

    public List<String> getAllCertificazioni() {
        List<String> certificazioni=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CERTIFICAZIONE FROM Build_Your_Dream.PSU ORDER BY CERTIFICAZIONE");
            ResultSet rsPSU=ps.executeQuery();
            while(rsPSU.next()){
                certificazioni.add(rsPSU.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return certificazioni;
    }

    public PSU getPezzo(int id) {
        PSU psu = null;
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            Pezzo pezzo = pezzoDAO.getPezzoFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.PSU where ID_PEZZO=?");
            ps.setInt(1, id);
            ResultSet rsPSU = ps.executeQuery();
            if (rsPSU.next()) {
                psu = new PSU(rsPSU.getInt(1), pezzo.getMarca(), pezzo.getModello(), pezzo.getPrezzo(), pezzo.getDisponibilita(), pezzo.getSconto(), rsPSU.getString(2), rsPSU.getInt(3), rsPSU.getString(4), rsPSU.getBoolean(5), rsPSU.getDouble(6));
            } else {
                throw new PezzoNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return psu;
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.PSU where ID_PEZZO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoPezzi","PSU",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(PSU psu) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.update(psu);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.PSU SET CATEGORIA=?, POTENZA=?, CERTIFICAZIONE=?, MODULARITA=?, PESO=? WHERE ID_PEZZO=?");
            ps.setString(1, psu.getCategoria());
            ps.setInt(2, psu.getPotenza());
            ps.setString(3, psu.getCertificazione());
            ps.setBoolean(4,psu.isModularita());
            ps.setDouble(5, psu.getPeso());
            ps.setInt(6,psu.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newPSU(PSU psu) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.newPezzo(psu);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.PSU VALUES (?,?,?,?,?,?)");
            ps.setInt(1,psu.getID());
            ps.setString(2,psu.getCategoria());
            ps.setInt(3,psu.getPotenza());
            ps.setString(4,psu.getCertificazione());
            ps.setBoolean(5,psu.isModularita());
            ps.setDouble(6,psu.getPeso());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
