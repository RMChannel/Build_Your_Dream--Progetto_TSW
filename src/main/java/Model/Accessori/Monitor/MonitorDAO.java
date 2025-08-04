package Model.Accessori.Monitor;

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

public class MonitorDAO {
    public List<Monitor> getAccessori() {
        List<Monitor> monitors = new ArrayList<>();
        try {
            AccessorioDAO accessorioDAO=new AccessorioDAO();
            HashMap<Integer, Accessorio> accessori=accessorioDAO.getAccessori();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.MONITOR");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Accessorio accessorio=accessori.get(rs.getInt(1));
                if(accessorio==null) throw new AccessorioNotFound();
                monitors.add(new Monitor(rs.getInt(1),accessorio.getMarca(),accessorio.getModello(),accessorio.getPrezzo(),accessorio.getDisponibilita(),accessorio.getSconto(),rs.getInt(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getDouble(6),rs.getInt(7),rs.getBoolean(8),rs.getBoolean(9)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return monitors;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO IN (SELECT MONITOR.ID_ACCESSORIO FROM Build_Your_Dream.MONITOR) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllRisoluzione() {
        List<String> resolutions=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT RESOLUTION FROM Build_Your_Dream.MONITOR ORDER BY RESOLUTION");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                resolutions.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return resolutions;
    }

    public List<String> getAllAspectRatios() {
        List<String> aspectRatios=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT ASPECT_RATIO FROM Build_Your_Dream.MONITOR ORDER BY ASPECT_RATIO");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                aspectRatios.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return aspectRatios;
    }

    public List<String> getAllTipi() {
        List<String> tipi=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT TIPO FROM Build_Your_Dream.MONITOR ORDER BY TIPO");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                tipi.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tipi;
    }

    public List<String> getAllRefreshRates() {
        List<String> refreshRates=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT FREQUENCY FROM Build_Your_Dream.MONITOR ORDER BY FREQUENCY");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                refreshRates.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return refreshRates;
    }

    public Monitor getPezzo(int id) {
        Monitor monitor = null;
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            Accessorio accessorio = accessorioDAO.getAccessorioFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.MONITOR where ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                monitor = new Monitor(rs.getInt(1), accessorio.getMarca(), accessorio.getModello(), accessorio.getPrezzo(), accessorio.getDisponibilita(), accessorio.getSconto(), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getInt(7), rs.getBoolean(8), rs.getBoolean(9));
            } else {
                throw new AccessorioNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return monitor;
    }

    public void update(Monitor monitor) {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.update(monitor);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.MONITOR SET DIMENSIONE=?, RESOLUTION=?, ASPECT_RATIO=?, TIPO=?, RESPONSE_TIME=?, FREQUENCY=?, HDR=?, CASSE=? WHERE ID_ACCESSORIO=?");
            ps.setInt(1, monitor.getDimensione());
            ps.setString(2,monitor.getRisoluzione());
            ps.setString(3, monitor.getAspectRatio());
            ps.setString(4, monitor.getTipo());
            ps.setDouble(5, monitor.getResponseTime());
            ps.setInt(6,monitor.getFrequenza());
            ps.setBoolean(7,monitor.isHdr());
            ps.setBoolean(8,monitor.isCasse());
            ps.setInt(9,monitor.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.MONITOR WHERE ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.delete(id);
            FotoDAO fotoDAO=new FotoDAO();
            fotoDAO.removeFoto(id,"fotoAccessori","Monitor",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newMonitor(Monitor monitor) throws IDAlreadyRegistred {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.newAccessorio(monitor);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.MONITOR VALUES (?,?,?,?,?,?,?,?,?)");
            ps.setInt(1, monitor.getID());
            ps.setInt(2, monitor.getDimensione());
            ps.setString(3, monitor.getRisoluzione());
            ps.setString(4, monitor.getAspectRatio());
            ps.setString(5, monitor.getTipo());
            ps.setDouble(6, monitor.getResponseTime());
            ps.setInt(7, monitor.getFrequenza());
            ps.setBoolean(8,monitor.isHdr());
            ps.setBoolean(9,monitor.isCasse());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
