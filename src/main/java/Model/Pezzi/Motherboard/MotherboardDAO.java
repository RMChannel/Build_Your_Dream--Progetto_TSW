package Model.Pezzi.Motherboard;

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

public class MotherboardDAO {
    public List<Motherboard> getPezzi() {
        List<Motherboard> motherboards = new ArrayList<>();
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            HashMap<Integer, Pezzo> piecies=pezzoDAO.getPezzi();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.MOTHERBOARD");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                Pezzo pezzo=piecies.get(rs.getInt(1));
                if(pezzo==null) throw new PezzoNotFound();
                motherboards.add(new Motherboard(rs.getInt(1),pezzo.getMarca(),pezzo.getModello(),pezzo.getPrezzo(),pezzo.getDisponibilita(),pezzo.getSconto(),rs.getString(2),rs.getString(3),rs.getString(4),rs.getInt(5),rs.getInt(6),rs.getInt(7),rs.getInt(8),rs.getBoolean(9),rs.getString(10),rs.getInt(11)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return motherboards;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO IN (SELECT MOTHERBOARD.ID_PEZZO FROM Build_Your_Dream.MOTHERBOARD) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllSockets() {
        List<String> sockets=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT SOCKET FROM Build_Your_Dream.MOTHERBOARD ORDER BY SOCKET");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                sockets.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return sockets;
    }

    public List<String> getAllTipiRam() {
        List<String> ram=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT TIPO_RAM FROM Build_Your_Dream.MOTHERBOARD ORDER BY TIPO_RAM");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                ram.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ram;
    }

    public List<String> getAllCategories() {
        List<String> categorie=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CATEGORIA FROM Build_Your_Dream.MOTHERBOARD ORDER BY CATEGORIA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                categorie.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categorie;
    }

    public List<String> getAllPCIE() {
        List<String> pcie=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT PCIE FROM Build_Your_Dream.MOTHERBOARD ORDER BY PCIE");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                pcie.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return pcie;
    }

    public Motherboard getPezzo(int id) {
        Motherboard motherboard = null;
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            Pezzo pezzo = pezzoDAO.getPezzoFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.MOTHERBOARD where ID_PEZZO=?");
            ps.setInt(1, id);
            ResultSet rsMB = ps.executeQuery();
            if (rsMB.next()) {
                motherboard = new Motherboard(rsMB.getInt(1), pezzo.getMarca(), pezzo.getModello(), pezzo.getPrezzo(), pezzo.getDisponibilita(), pezzo.getSconto(), rsMB.getString(2), rsMB.getString(3), rsMB.getString(4), rsMB.getInt(5), rsMB.getInt(6), rsMB.getInt(7), rsMB.getInt(8), rsMB.getBoolean(9), rsMB.getString(10), rsMB.getInt(11));
            } else {
                throw new PezzoNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return motherboard;
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.MOTHERBOARD WHERE ID_PEZZO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoPezzi","Motherboard",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(Motherboard motherboard) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.update(motherboard);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.MOTHERBOARD SET SOCKET=?, CATEGORIA=?, TIPO_RAM=?, NUMERO_SLOT=?, CAPACITA_RAM=?, NUMERO_SATA=?, NUMERO_M2N=?, WIFI=?, PCIE=?, NUMERO_PCIE=? WHERE ID_PEZZO=?");
            ps.setString(1, motherboard.getSocket());
            ps.setString(2, motherboard.getCategoria());
            ps.setString(3,motherboard.getTipo_ram());
            ps.setInt(4,motherboard.getnSlot());
            ps.setInt(5,motherboard.getCapacitaRAM());
            ps.setInt(6,motherboard.getnSata());
            ps.setInt(7,motherboard.getnM2());
            ps.setBoolean(8,motherboard.isWifi());
            ps.setString(9,motherboard.getPcie());
            ps.setInt(10,motherboard.getnPcie());
            ps.setInt(11,motherboard.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newMotherBoard(Motherboard motherboard) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.newPezzo(motherboard);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.MOTHERBOARD VALUES(?,?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1, motherboard.getID());
            ps.setString(2, motherboard.getSocket());
            ps.setString(3, motherboard.getCategoria());
            ps.setString(4, motherboard.getTipo_ram());
            ps.setInt(5, motherboard.getnSlot());
            ps.setInt(6, motherboard.getCapacitaRAM());
            ps.setInt(7, motherboard.getnSata());
            ps.setInt(8, motherboard.getnM2());
            ps.setBoolean(9, motherboard.isWifi());
            ps.setString(10, motherboard.getPcie());
            ps.setInt(11, motherboard.getnPcie());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
