package Model.Pezzi.RAM;

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
import java.util.List;

public class RAMDAO {
    public List<RAM> getPezzi() {
        List<RAM> rams=new ArrayList<>();
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.RAM");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Pezzo pezzo=pezzoDAO.getPezzi().get(rs.getInt(1));
                if(pezzo==null) throw new PezzoNotFound();
                rams.add(new RAM(rs.getInt(1),pezzo.getMarca(),pezzo.getModello(),pezzo.getPrezzo(),pezzo.getDisponibilita(),pezzo.getSconto(),rs.getInt(2),rs.getString(3),rs.getInt(4),rs.getString(5)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rams;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO IN (SELECT RAM.ID_PEZZO FROM Build_Your_Dream.RAM) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllCategories() {
        List<String> categories=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CATEGORIA FROM Build_Your_Dream.RAM ORDER BY CATEGORIA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                categories.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categories;
    }

    public List<Integer> getAllCapacities() {
        List<Integer> capacities=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CAPACITA FROM Build_Your_Dream.RAM ORDER BY CAPACITA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                capacities.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return capacities;
    }

    public List<String> getAllTipologie() {
        List<String> tipologie=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT TIPOLOGIA FROM Build_Your_Dream.RAM ORDER BY TIPOLOGIA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                tipologie.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tipologie;
    }

    public List<Integer> getAllFrequenze() {
        List<Integer> frequenze=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT FREQUENZA FROM Build_Your_Dream.RAM ORDER BY FREQUENZA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                frequenze.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return frequenze;
    }

    public RAM getPezzo(int id) {
        RAM ram = null;
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            Pezzo pezzo = pezzoDAO.getPezzoFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.RAM where ID_PEZZO=?");
            ps.setInt(1, id);
            ResultSet rsRAM = ps.executeQuery();
            if (rsRAM.next()) {
                ram = new RAM(rsRAM.getInt(1), pezzo.getMarca(), pezzo.getModello(), pezzo.getPrezzo(), pezzo.getDisponibilita(), pezzo.getSconto(), rsRAM.getInt(2), rsRAM.getString(3), rsRAM.getInt(4), rsRAM.getString(5));
            } else {
                throw new PezzoNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ram;
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.RAM WHERE ID_PEZZO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoPezzi","RAM",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(RAM ram) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.update(ram);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.RAM SET CAPACITA=?, CATEGORIA=?, FREQUENZA=?, TIPOLOGIA=? WHERE ID_PEZZO=?");
            ps.setInt(1, ram.getCapacita());
            ps.setString(2, ram.getCategoria());
            ps.setInt(3, ram.getFrequenza());
            ps.setString(4, ram.getTipologia());
            ps.setInt(5,ram.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newRAM(RAM ram) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.newPezzo(ram);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.RAM VALUES(?,?,?,?,?)");
            ps.setInt(1, ram.getID());
            ps.setInt(2, ram.getCapacita());
            ps.setString(3, ram.getCategoria());
            ps.setInt(4, ram.getFrequenza());
            ps.setString(5, ram.getTipologia());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
