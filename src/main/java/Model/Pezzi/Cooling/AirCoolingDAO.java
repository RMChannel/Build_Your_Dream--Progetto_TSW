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

public class AirCoolingDAO {
    public List<AirCooling> getPezzi() {
        List<AirCooling> airCoolings=new ArrayList<>();
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            HashMap<Integer, Pezzo> pezzi=pezzoDAO.getPezzi();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.AIRCOOLING");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Pezzo pezzo=pezzi.get(rs.getInt(1));
                if(pezzo==null) throw new PezzoNotFound();
                airCoolings.add(new AirCooling(rs.getInt(1),pezzo.getMarca(),pezzo.getModello(),pezzo.getPrezzo(),pezzo.getDisponibilita(),pezzo.getSconto(),rs.getString(2),rs.getInt(3),rs.getDouble(4),rs.getDouble(5),rs.getInt(6), rs.getInt(7),rs.getInt(8),rs.getBoolean(9),rs.getInt(10), rs.getString(11)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return airCoolings;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO IN (SELECT AIRCOOLING.ID_AIRCOOLING FROM Build_Your_Dream.AIRCOOLING) ORDER BY MARCA");
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
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT SOCKET FROM Build_Your_Dream.AIRCOOLING ORDER BY SOCKET");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                sockets.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return sockets;
    }

    public List<Integer> getAllDimVentole() {
        List<Integer> dimVentole=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT DimensioneVentola FROM Build_Your_Dream.AIRCOOLING ORDER BY DimensioneVentola");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                dimVentole.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return dimVentole;
    }

    public AirCooling getPezzo(int id) {
        AirCooling airCooling = null;
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            Pezzo pezzo = pezzoDAO.getPezzoFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.AIRCOOLING where ID_AIRCOOLING=?");
            ps.setInt(1, id);
            ResultSet rsAC = ps.executeQuery();
            if (rsAC.next()) {
                airCooling = new AirCooling(rsAC.getInt(1), pezzo.getMarca(), pezzo.getModello(), pezzo.getPrezzo(), pezzo.getDisponibilita(), pezzo.getSconto(), rsAC.getString(2), rsAC.getDouble(3), rsAC.getDouble(4), rsAC.getDouble(5), rsAC.getInt(6), rsAC.getInt(7), rsAC.getInt(8), rsAC.getBoolean(9), rsAC.getInt(10), rsAC.getString(11));
            } else {
                throw new PezzoNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return airCooling;
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.AIRCOOLING WHERE ID_AIRCOOLING=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoPezzi","AirCooling",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(AirCooling airCooling) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.update(airCooling);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.AIRCOOLING SET Socket=?, Altezza=?, Lunghezza=?, Larghezza=?, NVentole=?, DimensioneVentola=?, MaxRPM=?, RGB=?, TDP=?, Colore=? WHERE ID_AIRCOOLING=?");
            ps.setString(1, airCooling.getSocket());
            ps.setDouble(2,airCooling.getAltezza());
            ps.setDouble(3,airCooling.getLunghezza());
            ps.setDouble(4,airCooling.getLarghezza());
            ps.setInt(5,airCooling.getnVentole());
            ps.setDouble(6,airCooling.getDimVentola());
            ps.setInt(7,airCooling.getMaxRPM());
            ps.setBoolean(8,airCooling.isRgb());
            ps.setInt(9,airCooling.getTDP());
            ps.setString(10,airCooling.getColore());
            ps.setInt(11,airCooling.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newAirCooling(AirCooling airCooling) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.newPezzo(airCooling);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.AIRCOOLING VALUES (?,?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1,airCooling.getID());
            ps.setString(2, airCooling.getSocket());
            ps.setDouble(3,airCooling.getAltezza());
            ps.setDouble(4,airCooling.getLunghezza());
            ps.setDouble(5,airCooling.getLarghezza());
            ps.setInt(6,airCooling.getnVentole());
            ps.setDouble(7,airCooling.getDimVentola());
            ps.setInt(8,airCooling.getMaxRPM());
            ps.setBoolean(9,airCooling.isRgb());
            ps.setInt(10,airCooling.getTDP());
            ps.setString(11,airCooling.getColore());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
