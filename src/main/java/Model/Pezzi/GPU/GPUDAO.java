package Model.Pezzi.GPU;

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
import java.util.Map;

public class GPUDAO {
    public List<GPU> getPezzi() {
        List<GPU> gpus = new ArrayList<GPU>();
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            HashMap<Integer, Pezzo> pezzi=pezzoDAO.getPezzi();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.GPU");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                Pezzo pezzo=pezzi.get(rs.getInt(1));
                if(pezzo==null)  throw new PezzoNotFound();
                gpus.add(new GPU(rs.getInt(1),pezzo.getMarca(),pezzo.getModello(),pezzo.getPrezzo(),pezzo.getDisponibilita(),pezzo.getSconto(),rs.getString(2),rs.getInt(3),rs.getString(4),rs.getString(5),rs.getBoolean(6),rs.getInt(7),rs.getDouble(8),rs.getString(9)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return gpus;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO IN (SELECT GPU.ID_PEZZO FROM Build_Your_Dream.GPU) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<Integer> getAllVrams() {
        List<Integer> vrams=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT VRAM FROM Build_Your_Dream.GPU ORDER BY VRAM");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                vrams.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return vrams;
    }

    public GPU getPezzo(int id) {
        GPU gpu = null;
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            Pezzo pezzo = pezzoDAO.getPezzoFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.GPU where ID_PEZZO=?");
            ps.setInt(1, id);
            ResultSet rsGPU = ps.executeQuery();
            if (rsGPU.next()) {
                gpu = new GPU(rsGPU.getInt(1), pezzo.getMarca(), pezzo.getModello(), pezzo.getPrezzo(), pezzo.getDisponibilita(), pezzo.getSconto(), rsGPU.getString(2), rsGPU.getInt(3), rsGPU.getString(4), rsGPU.getString(5), rsGPU.getBoolean(6), rsGPU.getInt(7), rsGPU.getDouble(8), rsGPU.getString(9));
            } else {
                throw new PezzoNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return gpu;
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.GPU where ID_PEZZO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoPezzi","CPU",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void update(GPU gpu) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.update(gpu);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.GPU SET PRODUTTORE=?, VRAM=?, TIPO_VRAM=?, PCIE=?, OVERCLOCK=?,WATT=?, PESO=?, MEM_CLOCK=? WHERE ID_PEZZO=?");
            ps.setString(1,gpu.getProduttore());
            ps.setInt(2,gpu.getVRAM());
            ps.setString(3,gpu.getVRAMtype());
            ps.setString(4,gpu.getPcie());
            ps.setBoolean(5,gpu.isOverclock());
            ps.setInt(6,gpu.getWatt());
            ps.setDouble(7,gpu.getPeso());
            ps.setString(8,gpu.getMemFrequence());
            ps.setInt(9,gpu.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newGPU(GPU gpu) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.newPezzo(gpu);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.GPU VALUES (?,?,?,?,?,?,?,?,?)");
            ps.setInt(1,gpu.getID());
            ps.setString(2,gpu.getProduttore());
            ps.setInt(3,gpu.getVRAM());
            ps.setString(4,gpu.getVRAMtype());
            ps.setString(5,gpu.getPcie());
            ps.setBoolean(6,gpu.isOverclock());
            ps.setInt(7,gpu.getWatt());
            ps.setDouble(8,gpu.getPeso());
            ps.setString(9,gpu.getMemFrequence());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
