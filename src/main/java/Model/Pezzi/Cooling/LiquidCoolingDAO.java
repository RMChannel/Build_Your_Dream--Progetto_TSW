package Model.Pezzi.Cooling;

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

public class LiquidCoolingDAO {
    public List<LiquidCooling> getPezzi() {
        List<LiquidCooling> piecies = new ArrayList<>();
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            HashMap<Integer, Pezzo> pezzi=pezzoDAO.getPezzi();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.LIQUIDCOOLING");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Pezzo pezzo=pezzi.get(rs.getInt(1));
                if(pezzo==null) throw new PezzoNotFound();
                piecies.add(new LiquidCooling(rs.getInt(1),pezzo.getMarca(),pezzo.getModello(),pezzo.getPrezzo(),pezzo.getDisponibilita(),pezzo.getSconto(),rs.getString(2),rs.getInt(3),rs.getDouble(4),rs.getDouble(5),rs.getInt(6),rs.getInt(7),rs.getInt(8),rs.getBoolean(9),rs.getInt(10),rs.getString(11),rs.getBoolean(12)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return piecies;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO IN (SELECT LIQUIDCOOLING.ID_LIQUIDCOOLING FROM Build_Your_Dream.LIQUIDCOOLING) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
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
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT SOCKET FROM Build_Your_Dream.LIQUIDCOOLING ORDER BY SOCKET");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                sockets.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return sockets;
    }

    public LiquidCooling getPezzo(int id) {
        LiquidCooling liquidCooling = null;
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            Pezzo pezzo = pezzoDAO.getPezzoFromID(id);
            Connection conn = DB.getConn();
                PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.LIQUIDCOOLING where ID_LIQUIDCOOLING=?");
            ps.setInt(1, id);
            ResultSet rsLC = ps.executeQuery();
            if (rsLC.next()) {
                liquidCooling = new LiquidCooling(rsLC.getInt(1), pezzo.getMarca(), pezzo.getModello(), pezzo.getPrezzo(), pezzo.getDisponibilita(), pezzo.getSconto(), rsLC.getString(2), rsLC.getDouble(3), rsLC.getDouble(4), rsLC.getDouble(5), rsLC.getDouble(6), rsLC.getInt(7), rsLC.getInt(8), rsLC.getBoolean(9), rsLC.getInt(10), rsLC.getString(11), rsLC.getBoolean(12));
            } else {
                throw new PezzoNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return liquidCooling;
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.LIQUIDCOOLING WHERE ID_LIQUIDCOOLING=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoPezzi","LiquidCooling",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(LiquidCooling liquidCooling) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.update(liquidCooling);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.LIQUIDCOOLING SET Socket=?, Altezza=?, Lunghezza=?, Larghezza=?, DimensioneRadiatore=?, NVentole=?, MaxRPM=?, RGB=?, TDP=?, Colore=?, Display=? WHERE ID_LIQUIDCOOLING=?");
            ps.setString(1, liquidCooling.getSocket());
            ps.setDouble(2, liquidCooling.getAltezza());
            ps.setDouble(3, liquidCooling.getLunghezza());
            ps.setDouble(4, liquidCooling.getLarghezza());
            ps.setDouble(5, liquidCooling.getDimRadiatore());
            ps.setInt(6,liquidCooling.getnVentole());
            ps.setDouble(7, liquidCooling.getMaxRPM());
            ps.setBoolean(8,liquidCooling.isRgb());
            ps.setInt(9,liquidCooling.getTdp());
            ps.setString(10,liquidCooling.getColore());
            ps.setBoolean(11,liquidCooling.isDisplay());
            ps.setInt(12,liquidCooling.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newLiquidCooling(LiquidCooling liquidCooling) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.newPezzo(liquidCooling);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.LIQUIDCOOLING VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1,liquidCooling.getID());
            ps.setString(2, liquidCooling.getSocket());
            ps.setDouble(3,liquidCooling.getAltezza());
            ps.setDouble(4, liquidCooling.getLunghezza());
            ps.setDouble(5, liquidCooling.getLarghezza());
            ps.setDouble(6, liquidCooling.getDimRadiatore());
            ps.setInt(7,liquidCooling.getnVentole());
            ps.setDouble(8, liquidCooling.getMaxRPM());
            ps.setBoolean(9,liquidCooling.isRgb());
            ps.setInt(10,liquidCooling.getTdp());
            ps.setString(11,liquidCooling.getColore());
            ps.setBoolean(12,liquidCooling.isDisplay());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
