package Model.PreBuilts;

import Database.DB;
import Foto.FotoDAO;
import Model.Pezzi.PezzoNotFound;
import Model.QuantityNotSufficientException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PreBuiltDAO {
    public List<PreBuilt> getAllPreBuilts() {
        List<PreBuilt> preBuilts = new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.PREBUILT");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                preBuilts.add(new PreBuilt(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getInt(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getInt(10),rs.getInt(11)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return preBuilts;
    }

    public PreBuilt getPrebuiltByID(int ID) {
        PreBuilt preBuilt=null;
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.PREBUILT WHERE Id_prodotto=?");
            ps.setInt(1,ID);
            ResultSet rs=ps.executeQuery();
            if(rs.next()) preBuilt=new PreBuilt(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5),rs.getInt(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getInt(10),rs.getInt(11));
            else throw new PrebuiltNotFound();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return preBuilt;
    }

    public List<String> getAllMarche() {
        List<String> marche = new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT Marca FROM Build_Your_Dream.PREBUILT ORDER BY Marca");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllCpus() {
        List<String> cpus = new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CPU FROM Build_Your_Dream.PREBUILT ORDER BY CPU");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                cpus.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return cpus;
    }

    public List<String> getAllGpus() {
        List<String> gpus = new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT GPU FROM Build_Your_Dream.PREBUILT ORDER BY GPU");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                gpus.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return gpus;
    }

    public List<Integer> getAllRam() {
        List<Integer> ram = new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT RAM FROM Build_Your_Dream.PREBUILT ORDER BY RAM");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                ram.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ram;
    }

    public List<Integer> getAllDisk() {
        List<Integer> disk = new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT Memory FROM Build_Your_Dream.PREBUILT ORDER BY Memory");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                disk.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return disk;
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.PREBUILT WHERE Id_prodotto=?");
            ps.setInt(1,id);
            ps.executeUpdate();
            FotoDAO fotoDAO=new FotoDAO();
            fotoDAO.removeAllFotos(id,path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(PreBuilt prebuilt) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.PREBUILT SET Marca=?, Modello=?, Prezzo=?, Disponibilita=?, Sconto=?, Descrizione=?, CPU=?, GPU=?, RAM=?, Memory=? WHERE Id_prodotto=?");
            ps.setString(1,prebuilt.getMarca());
            ps.setString(2,prebuilt.getModello());
            ps.setDouble(3,prebuilt.getPrezzo());
            ps.setInt(4,prebuilt.getDisponibilita());
            ps.setInt(5,prebuilt.getSconto());
            ps.setString(6,prebuilt.getDescrizione());
            ps.setString(7,prebuilt.getCPU());
            ps.setString(8,prebuilt.getGPU());
            ps.setInt(9,prebuilt.getRAM());
            ps.setInt(10,prebuilt.getMemory());
            ps.setInt(11,prebuilt.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newPrebuilt(PreBuilt prebuilt) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.PREBUILT VALUES(?,?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1,prebuilt.getID());
            ps.setString(2,prebuilt.getMarca());
            ps.setString(3,prebuilt.getModello());
            ps.setDouble(4,prebuilt.getPrezzo());
            ps.setInt(5,prebuilt.getDisponibilita());
            ps.setInt(6,prebuilt.getSconto());
            ps.setString(7,prebuilt.getDescrizione());
            ps.setString(8,prebuilt.getCPU());
            ps.setString(9,prebuilt.getGPU());
            ps.setInt(10,prebuilt.getRAM());
            ps.setInt(11,prebuilt.getMemory());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void decreaseQuantity(PreBuilt preBuilt, int quantity) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISPONIBILITA FROM Build_Your_Dream.PREBUILT WHERE Id_prodotto=?");
            ps.setInt(1,preBuilt.getID());
            ResultSet rs=ps.executeQuery();
            int disponibilita=0;
            if(rs.next()) {
                disponibilita=rs.getInt(1);
            }
            else throw new PrebuiltNotFound();
            if(disponibilita-quantity<0) {
                throw new QuantityNotSufficientException();
            }
            ps=conn.prepareStatement("UPDATE Build_Your_Dream.PREBUILT SET DISPONIBILITA=? WHERE Id_prodotto=?");
            ps.setInt(1,disponibilita-quantity);
            ps.setInt(2,preBuilt.getID());
            ps.executeUpdate();
        } catch (SQLException e) {

            throw new RuntimeException(e);
        }
    }

    public void increaseQuantity(PreBuilt preBuilt, int quantity) {
        if(quantity<=0) {
            throw new QuantityNotSufficientException();
        }
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISPONIBILITA FROM Build_Your_Dream.PREBUILT WHERE Id_prodotto=?");
            ps.setInt(1,preBuilt.getID());
            ResultSet rs=ps.executeQuery();
            int disponibilita=0;
            if(rs.next()) {
                disponibilita=rs.getInt(1);
            }
            else throw new PezzoNotFound();
            ps=conn.prepareStatement("UPDATE Build_Your_Dream.PREBUILT SET DISPONIBILITA=? WHERE Id_prodotto=?");
            ps.setInt(1,disponibilita+quantity);
            ps.setInt(2,preBuilt.getID());
            ps.executeUpdate();
        } catch (SQLException e) {

            throw new RuntimeException(e);
        }
    }
}